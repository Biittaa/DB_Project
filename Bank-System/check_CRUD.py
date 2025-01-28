from CRUD import dbManager

# Create an instance of dbManager
db = dbManager()

# Call the create method on the db instance
db.create("user", {
    "FirstName": "David", 
    "LastName": "Mills",
    "PhoneNumber": "2145551233", 
    "Email": "davidmillss8@gmail.com",
    "userAddress": "12 Main St",
    "DateOfBirth": "1985-11-02 00:00:00"
})


db.create("customer",{
    "UserID" : "20",
    "CustomerType" : "Legal"
}
)


db.create("bankaccounts",{
    "CustomerID" : "6",
    "AccountNumber" : "1921072918",
    "AccountType" : "Savings",
    "Balance" : "25000",
    "AccountStatus": "Active",
    "closedAt" : None
}

)


db.update(
    "user",{
        "userAddress" : "456 Elm st"
    }, 
    {
        "UserID" : "20"
    }
)


db.update(
    "bankaccounts",
    {"AccountStatus" : "Closed"},
    {"AccountID" : "22" }

)


db.delete(
    "bankaccounts",
    {"AccountID" : "22"}
)


results =db.read(
    "user",
    {"LastName","FirstName"}
)

for e in results:
    print(e)


results = db.read(
    "bankaccounts",
    {"*"},
    {"AccountStatus" : "Active"}
)


for e in results:
    print(e)


db.closeConnection()
