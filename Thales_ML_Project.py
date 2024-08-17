# -*- coding: utf-8 -*-
"""
Created on Sat Aug 17 10:55:32 2024

@author: james
"""

# -*- coding: utf-8 -*-
"""
This is my Predicitve Analytics Project redux
Previoulsy used Powershell, R, SQL Server, PowerBI

This Will be Python exclusive, with SQL Server and PowerBI
Thales Stock Price Predictive Analysis

INPUT:
    Stock Prices from Yahoo Finance
PROCESS:
    Connect to DB
    Extract Latest Date
    Downlaod Current Data
    Update Database after current date plus 10 days
    Feature Engineering
    Find ML Model
    Train ML Model
    Save Model
        If model better Save
        If model is worse, keep previous model
        record model statistic with each iteration
    Load Data into PowerBI
    Load ML Model into PowerBI
OUTPUT
    Database data update
    ML Model
    Power BI Dashboard

@Author James Laurence
@Date August 17th, 2024
"""

# %% Imports, Filepaths, Variables

import pandas as pd
import numpy as np
import pickle
import requests
import os
import pyodbc
import scipy
import sklearn
from datetime import datetime as dt, timedelta as td
import sqlalchemy

TODAY_DATE = dt.today()
SCRIPT_PATH = r"E:/NSCC/5-Data Analytics Winter 2024/DBAS3090 - Applied Data Analytics/PythonProject"
MODEL_SAVE_FP = r'ICE/ICE 2'
SQL_Server = '{ODBC Driver 18 for SQL Server}'


cnxn = pyodbc.connect(f"Driver={SQL_Server};Server=MSI;Database=ThalesStockPredictor;trusted_connection=yes")


# %% Connect to Sql Server

cnxn = pyodbc.connect(f"Driver={SQL_Server};Server=MSI;Database=ThalesStockPredictor;trusted_connection=yes")

cnxn.close()
