import pandas as pd

file_path = "01_Ham_Veriler/is_ilanlari_ham.xlsx"

df = pd.read_excel(file_path)

print("Sütunlar:")
print(df.columns.tolist())

print("\nİlk 5 kayıt:")
print(df.head())

print("\nVeri boyutu:")
print(df.shape)