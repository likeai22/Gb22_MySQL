import random

from faker import Faker
from abc import abstractmethod, ABC
import pymysql
from pymysql import Error
import configparser


class IDatabaseInterface(ABC):
    @abstractmethod
    def connection(self):
        pass

    @abstractmethod
    def exec_query(self, **kwargs):
        pass

    @abstractmethod
    def exec_non_query(self, **kwargs):
        pass

    @abstractmethod
    def exec_many(self, **kwargs):
        pass

    @abstractmethod
    def close_connection(self):
        pass


class Singleton:
    __instance = None

    def __init__(self):
        if not Singleton.__instance:
            print("__init__method callded")
        else:
            print("Instance already created:", self.getInstance())

    @classmethod
    def getInstance(cls):
        if not cls.__instance:
            cls.__instance = Singleton()
        return cls.__instance


class MySql(IDatabaseInterface):
    def __init__(
            self,
            host=None,
            user=None,
            password=None,
            database_name=None,
            port=None):
        self.conn = None
        self.cursor = None

        self.host = host
        self.user = user
        self.password = password
        self.db = database_name
        self.port = port

    def connection(self):
        try:
            self.conn = pymysql.connect(
                host=self.host,
                user=self.user,
                password=self.password,
                db=self.db,
                port=self.port,
                charset="utf8",
            )
            self.cursor = self.conn.cursor()
            return self.conn
        except Error as e:
            print(e)
        return self.conn

    def exec_query(self, data):
        self.cursor.execute(data)
        data = self.cursor.fetchall()
        return data

    def exec_non_query(self, data, fields=None):
        if fields is None:
            self.cursor.execute(data)
        else:
            self.cursor.execute(data, fields)
        self.conn.commit()
        return self.cursor.fetchone()

    def exec_many(self, data, fields):
        self.cursor.executemany(data, fields)
        self.conn.commit()

    def close_connection(self):
        self.conn.close()


class DataBase(Singleton):

    def __init__(self):
        super().__init__()
        try:
            parser = configparser.ConfigParser()
            parser.read('config.ini')

            if 'Database' in parser:
                db = parser['Database']['db']
                if db == 'Mysql':
                    self.db = MySql(
                        host=parser['MysqlDatabase']['host'],
                        user=parser['MysqlDatabase']['user'],
                        password=parser['MysqlDatabase']['password'],
                        database_name=parser['MysqlDatabase']['database_name'],
                        port=int(
                            parser['MysqlDatabase']['port']))
                elif db == 'Sqlite':
                    pass
                self.db.connection()

        except configparser.ParsingError as err:
            print('Could not parse:', err)

    def find(self, data_sql):
        return self.db.exec_query(data_sql)

    def add(self, data_sql, fields=None):
        if fields is None:
            return self.db.exec_non_query(data_sql)
        else:
            return self.db.exec_non_query(data_sql, fields)

    def add_many(self, data_sql, fields):
        self.db.exec_many(data_sql, fields)

    def clear(self):
        self.db.close_connection()


if __name__ == '__main__':
    conn = DataBase()
    faker = Faker()

    find_user_id = "SELECT id FROM users WHERE phone = %s"
    find_photo_albums_id = "SELECT id FROM photo_albums WHERE user_id=%s"
    find_media_id = "SELECT id FROM media WHERE user_id=%s"
    find_photo_id = "SELECT id FROM photos WHERE user_id=%s"
    find_media_type = "SELECT id FROM media_types WHERE name=%s"

    insert_users = "INSERT INTO users (firstname, lastname, email, password_hash, phone) " \
                   " VALUES (%s, %s, %s, %s, %s)"
    insert_profiles = "INSERT INTO profiles (user_id, gender, birthday, photo_id, hometown) " \
                      " VALUES (%s, %s, %s, %s, %s)"
    insert_messages = "INSERT INTO messages (from_user_id, to_user_id, body) " \
                      " VALUES (%s, %s, %s)"
    insert_friend_requests = "INSERT INTO friend_requests (initiator_user_id, target_user_id, status, updated_at) " \
                             " VALUES (%s, %s, %s, %s) "
    insert_communities = "INSERT INTO communities (name, admin_user_id) VALUES (%s, %s)"
    insert_user_communities = "INSERT INTO user_communities (user_id, community_id)" \
                              " VALUES (%s, %s)"
    insert_media_types = "INSERT INTO media_types (name, updated_at) VALUES (%s, %s)"
    insert_media = "INSERT INTO media (media_type_id, user_id, body, filename, size, metadata, updated_at)" \
                   " VALUES (%s, %s, %s, %s, %s, %s, %s)"
    insert_likes = "INSERT INTO likes (user_id, media_id)" \
                   " VALUES (%s, %s)"
    insert_photo_albums = "INSERT INTO photo_albums (name, user_id)" \
                          " VALUES (%s, %s)"
    insert_photos = "INSERT INTO photos (album_id, media_id)" \
                    " VALUES (%s, %s)"

    insert_services = "INSERT INTO services (name, cost)" \
                      " VALUES (%s, %s)"
    insert_user_services = "INSERT INTO user_services (user_id, service_id, received_at, cost_of_service) " \
                           " VALUES (%s, %s, %s, %s) "
    insert_payment_methods = "INSERT INTO payment_methods (name) VALUES (%s)"
    insert_payment_statuses = "INSERT INTO payment_statuses (name, updated_at) VALUES (%s, %s)"
    insert_user_payment_methods = "INSERT INTO user_payment_methods (user_id, payment_method_id," \
                                  " card_number, card_expire_data) VALUES (%s, %s, %s, %s) "
    insert_payments = "INSERT INTO payments (payment_service_id, payment_method_id, payment_status_id) " \
                      " VALUES (%s, %s, %s)"

    quantity = 150
    for _ in range(quantity):
        try:
            add_user = (faker.first_name(),
                        faker.last_name(),
                        faker.ascii_free_email(),
                        faker.md5(),
                        faker.msisdn())
            conn.add(insert_users, add_user)

            user_id = conn.add(find_user_id, add_user[4])

            add_media_types = (faker.random_element(elements=('image', 'video', 'text')),
                               faker.date_time_this_decade(False, True).strftime('%Y-%m-%d %H:%M:%S'))
            conn.add(insert_media_types, add_media_types)

            media_types = conn.add(find_media_type, add_media_types[0])

            add_media = (media_types,
                         user_id,
                         faker.text(max_nb_chars=100),
                         faker.file_name(category='image'),
                         faker.pyint(),
                         faker.json(data_columns=[('Name', 'name'),
                                                  ('Points', 'pyint', {'min_value': 50, 'max_value': 100})],
                                    num_rows=random.randint(1, 3)),
                         faker.date_time_this_decade(False, True).strftime('%Y-%m-%d %H:%M:%S')
                         )
            conn.add(insert_media, add_media)

            add_photo_album = (faker.domain_word(),
                               user_id)
            conn.add(insert_photo_albums, add_photo_album)

            album_id = conn.add(find_photo_albums_id, user_id)
            media_id = conn.add(find_media_id, user_id)

            add_photo = (album_id,
                         media_id)
            conn.add(insert_photos, add_photo)

            add_profile = (user_id,
                           faker.random_element(elements=('m', 'w')),
                           faker.date_of_birth(),
                           media_id,
                           faker.city())
            conn.add(insert_profiles, add_profile)

            add_community = (faker.catch_phrase(),
                             random.randint(1, int(quantity / 5)))
            conn.add(insert_communities, add_community)

            add_service = (faker.catch_phrase(),
                           random.randint(5, 500))
            conn.add(insert_services, add_service)

            add_payment_method = (faker.random_element(elements=('MasterCard', 'Visa', 'ЮMoney')),)
            conn.add(insert_payment_methods, add_payment_method)

            add_payment_status = (faker.random_element(elements=('Completed', 'Canceled', 'Disputed')),
                                  faker.date_time_this_decade(False, True).strftime('%Y-%m-%d %H:%M:%S'))
            conn.add(insert_payment_statuses, add_payment_status)

        except Exception as e:
            print(e)

    for _ in range(quantity):
        try:
            add_message = (random.randint(1, quantity),
                           random.randint(1, quantity),
                           faker.text(max_nb_chars=100))
            conn.add(insert_messages, add_message)

            add_users_community = (random.randint(1, quantity),
                                   random.randint(1, quantity))
            conn.add(insert_user_communities, add_users_community)

            add_likes = (random.randint(1, quantity),
                         random.randint(1, quantity))
            conn.add(insert_likes, add_likes)

            add_friend_request = (random.randint(1, quantity),
                                  random.randint(1, quantity),
                                  faker.random_element(
                                      elements=('requested', 'approved', 'declined', 'unfriended')),
                                  faker.date_time_this_decade(False, True).strftime('%Y-%m-%d %H:%M:%S'))
            conn.add(insert_friend_requests, add_friend_request)

            add_user_service = (random.randint(1, quantity),
                                random.randint(1, quantity),
                                faker.date_time_this_decade(False, True).strftime('%Y-%m-%d %H:%M:%S'),
                                random.randint(5, 500))
            conn.add(insert_user_services, add_user_service)

            add_user_payment_method = (random.randint(1, quantity),
                                       random.randint(1, quantity),
                                       faker.credit_card_number(),
                                       faker.credit_card_expire())
            conn.add(insert_user_payment_methods, add_user_payment_method)

            add_payments = (random.randint(1, quantity),
                            random.randint(1, quantity),
                            random.randint(1, quantity))
            conn.add(insert_payments, add_payments)

        except Exception as e:
            print(e)
