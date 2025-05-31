from pydantic import BaseModel, Field
from typing import Optional, Literal
from datetime import datetime


class User(BaseModel):
    """
    Base model for shared attributes between Customer and Employee.
    """
    first_name: str 
    last_name: str 
    phone_number: str 
    email: Optional[str] 
    address: Optional[str]
    date_of_birth: Optional[datetime]
    created_at: Optional[datetime] 


class Customer(User):
    """
    Model for the Customer table inheriting from User.
    """
    customer_id: Optional[int] 
    customer_type: Literal['Legal', 'Normal']


class Employee(User):
    """
    Model for the Employee table inheriting from User.
    """
    employee_id: Optional[int] 
    job_position: str 


class BankAccount(BaseModel):
    """
    Model for the BankAccounts table.
    """
    account_id: Optional[int] 
    customer_id: int
    account_number: str 
    account_type: str 
    balance: float 
    account_status: Literal['Active', 'Suspended', 'Closed'] = 'Active'
    created_at: Optional[datetime] 
    closed_at: Optional[datetime]


class Transaction(BaseModel):
    """
    Model for the TransactionTable table.
    """
    transaction_id: Optional[int] 
    source_account: int
    destination_account: Optional[int]
    transaction_amount: float 
    transaction_date: Optional[datetime] 
    transaction_type: Literal['withdraw', 'deposit', 'transfer']


class Loan(BaseModel):
    """
    Model for the Loan table.
    """
    loan_id: Optional[int] 
    loan_type: Literal['Education Loan', 'Mortgage', 'Personal Loan']
    customer_id: int
    interest_rate: float 
    loan_amount: float
    payback_period_months: int 
    start_date: datetime
    end_date: datetime
    loan_status: Literal['Active', 'Closed'] = 'Active'


class Installment(BaseModel):
    """
    Model for the Installment table.
    """
    installment_id: Optional[int] 
    loan_id: int
    scheduled_payment_date: datetime
    actual_payment_date: Optional[datetime]
    amount_paid: float = Field(ge=0, default=0.0)
    interest_amount: float = Field(ge=0, default=0.0)
    total_amount_paid: Optional[float] 
