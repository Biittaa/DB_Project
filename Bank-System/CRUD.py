import mysql.connector
from typing import Dict,Optional


class dbManager:
    def __init__(self):
        self.connection=mysql.connector.connect(
            host="localhost",         
            port=3306,                 
            user="root",      
            password="456456Bita",  
            database="Bita" 
    )
        self.cur = self.connection.cursor()
    

    def closeConnection(self):
        self.cur.close()
        self.connection.close()

    def create(self,table:str,data:Dict[any,any]):

        columns = ", ".join(data.keys())
        params = ", ".join(["%s"]*len(data))
        query = f"INSERT INTO {table} ({columns}) VALUES ({params})"
        self.cur.execute(query,tuple(data.values()))
        self.connection.commit()
        return self.cur.lastrowid


    def read(self,table:str,columns : list[str],conditions: Optional[Dict[any,any]] = None):

        selected_columns = ", ".join(columns)
        query = f"SELECT {selected_columns} FROM {table}"

        if conditions:
            where_clause = " AND".join([f"{key} = %s" for key in conditions.keys()]) 
            query += f" WHERE {where_clause}"   
            self.cur.execute(query,tuple(conditions.values()))
        else:
            self.cur.execute(query)

        return self.cur.fetchall()
    

    def update(self,table:str,data:Dict[any,any],conditions:Dict[any,any]):

        set_clause = ", ".join([f"{key} = %s" for key in data.keys()])
        where_clause = "AND ".join([f"{key} = %s" for key in conditions.keys()])
        query =f"UPDATE {table} SET {set_clause} WHERE {where_clause}"
        self.cur.execute(query, tuple(data.values()) + tuple(conditions.values()))
        self.connection.commit()
        return self.cur.rowcount
    

    def delete(self,table:str,conditions:Dict[any,any]):

        where_clause = "AND ".join([f"{key} = %s" for key in conditions.keys()])
        query = f"DELETE FROM {table} WHERE {where_clause}"
        self.cur.execute(query , tuple(conditions.values()))
        self.connection.commit()
        return self.cur.rowcount
    
    
    





