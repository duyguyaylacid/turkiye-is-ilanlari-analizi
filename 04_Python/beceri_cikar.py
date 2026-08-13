import pandas as pd

input_file = "02_Temiz_Veriler/is_ilanlari_temiz.xlsx"
output_file = "02_Temiz_Veriler/is_ilanlari_temiz.xlsx"

df = pd.read_excel(input_file)

# Aranacak teknik beceriler
skills = [
    "Python",
    "SQL",
    "Excel",
    "Power BI",
    "Tableau",
    "Power Query",
    "DAX",
    "C#",
    "C++",
    ".NET",
    "Java",
    "JavaScript",
    "React",
    "Angular",
    "Git",
    "GitHub",
    "Azure",
    "AWS",
    "Docker",
    "Kubernetes",
    "PostgreSQL",
    "MySQL",
    "Oracle",
    "SAP",
    "R",
    "Pandas",
    "NumPy",
    "TensorFlow",
    "Machine Learning"
]

def find_skills(text):
    text = str(text).lower()
    found = []

    for skill in skills:
        if skill.lower() in text:
            found.append(skill)

    return ", ".join(found)


# Açıklamadan becerileri çıkar
df["Teknik Beceriler"] = df["Açıklama"].apply(find_skills)

# Her ilanda kaç beceri bulundu?
df["Teknik Beceri Sayısı"] = df["Teknik Beceriler"].apply(
    lambda x: 0 if not x else len(x.split(", "))
)

df.to_excel(output_file, index=False)

print("Teknik beceriler çıkarıldı.")
print(f"Toplam ilan: {len(df)}")
print("Dosya güncellendi:", output_file)