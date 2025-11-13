# Titanic túlélési előrejelzés – Neurális hálóval

## Projekt célja
Ez a projekt a **Titanic – Machine Learning from Disaster** adathalmaz alapján készült.  
A cél a **túlélés valószínűségének előrejelzése** a hajó utasainak adatai alapján (pl.: nem, életkor, osztály, családméret).

---

## Projekt felépítése

- `titanic.ipynb` - fő notebook – adatkezelés és modell
- `docs` mappa - a beadandó követelményei
- `titanic` mappa - Titanic adatfájlok (Kaggle-ről)
- `setup_venv.bat` - virtuális környezetet létrehozó batch fájl:
    - Ellenőrzi, hogy létezik-e már a virtuális környezet (`venv`)
    - Ha nem létezik, létrehozza azt
    - Aktiválja a venv-et, és telepíti a szükséges csomagokat (`requirements.txt` fájl alapján)
    - Használathoz csak futtatni kell a batch fájlt
- `requirements.txt` - használt csomagok listája (numpy, pandas, matplotlib, scikit-learn, seaborn, tensorflow és függőségeik)
- `README.md` - ez a dokumentáció

---

## Fő lépések

### 1️. Adatok betöltése
- `pandas` segítségével a `train.csv` fájl betöltése
- Adatok megtekintése (`head()`, `describe()`)

---

### 2. Hiányzó és kiugró értékek kezelése
- Hiányzó értékek elemzése
    - A hiányzó értékek vizsgálatánál észrevettem, hogy a `Cabin` oszlopban rengeteg adat (kb. 80%) hiányzik. Ezért ezt a feature-t eldobtam, nem használtam fel a modellben.
    - Az `Age` és `Fare` oszlopokban a hiányzó adatokat mediánnal pótoltam
    - Az `Embarked` oszlopban pedig a leggyakoribb kategóriával (módusz) pótoltam a hiányzó adatokat (`mode()`)
    - A hiányzó értékek pótlása során az eredeti `train` és `test` adathalmazokat változatlanul hagytam, a feldolgozott változatokat `train_new` és `test_new` néven tároltam el.
- Felesleges adatok
    - a `PassengerId` oszlopot is eldobtam, hiszen csak egy sorszám, és nincs köze a túléléshez
- Outlierek elemzése
    - az `Age` és `Fare` oszlopokat vizsgáltam boxen plot segítségével
        - az `Age` oszlop teljesen rendben volt
        - a `Fare` oszlopban van kiugró érték (500 körül), de ezek elvileg valós első osztályú jegyárak, ezért nem lettek eltávolítva

---

### 3. Feature engineering

- Létrehoztam két új feature-t:
    - `FamilySize`:
        - `SibSp` + `Parch` + 1
        - `SibSp`: testvér(ek) és házastárs
        - `Parch`: szülő(k), gyerek(ek)
        - +1: maga az utas
    - `IsAlone`:
        - `FamilySize` feature szerint készítettem
        - ha a `FamilySize` = 1, akkor egyedül utazik
    - `Title`
        - A `Name` oszlopból regex kifejezés segítségével kinyertem a `Title`-t
        - Ezután a `Name` oszlopot eldobtam, mert szerintem nem releváns a megoldásban
    - `Embarked`:
        - Hol szállt fel az utas
        - One-hot encoding-al numerikussá alakítottam (C,Q,S)

---

### 4. Normalizálás és standardizálás

---

### 5. Modell – Neurális háló

---

### 6. Modell tanítása és értékelése

---

### 7. Eredmény
A neurális háló **__** ért el a validációs adatokon 

---

## Használt könyvtárak

- `pandas`
- `numpy`
- `matplotlib`
- `seaborn`
- `scikit-learn`
- `tensorflow`

---

## Készítette
**Varga Zsófia X49HPQ**  
Gépi tanulás beadandó 2025