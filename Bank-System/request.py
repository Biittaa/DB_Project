from fastapi import FastAPI

from typing import Dict,Optional

from CRUD import dbManager


app = FastAPI()


@app.post("/insert/")

async def insert(table:str,data:Dict[str,str]):
    db = dbManager()
    try:
        db.create(table,data)
        return {"status": "success"}
    except Exception as e:
        return {"status": "error", "message": "failed"}
    finally:
        db.closeConnection()
    


@app.get("/select/")

async def select(table:str,columns : list[str],conditions: Optional[Dict[str,str]] = None):

    db = dbManager()
    try:
        info = db.read(table, columns, conditions)
        return {"status": "success", "data": info}
    except Exception as e:
        return {"status": "error", "message": str(e)}
    finally:
        db.closeConnection()


@app.patch("/update/")
async def update(table:str,data:Dict[str,str],conditions:Dict[str,str]):
    db = dbManager()
    try:
        db.update(table,data,conditions)
        return {"status": "success"}
    except Exception as e:
        return {"status": "error", "message": "User update failed"}
    finally:
        db.closeConnection()



@app.delete("/delete/")
async def delete(table:str,conditions:Dict[str,str]):
    db = dbManager()
    try:
        db.delete(table,conditions)
        return {"status": "success"}
    except Exception as e:
        return {"status": "error", "message": "pv deleted failed"}
    finally:
        db.closeConnection()
