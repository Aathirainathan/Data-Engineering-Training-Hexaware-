
class DBPropertyUtil:
    @staticmethod
    def get_connection_string():
        return 'Driver={SQL Server};Server=PUMA\\SQLEXPRESS;Database=SISDB;Trusted_Connection=yes;'
