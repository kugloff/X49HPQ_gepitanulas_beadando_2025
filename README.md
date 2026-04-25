# Titanic túlélési előrejelzés – Neurális hálóval

## Projekt célja
Ez a projekt a **Titanic – Machine Learning from Disaster** adathalmaz alapján készült.  
A cél a **túlélés valószínűségének előrejelzése** a hajó utasainak adatai alapján (pl.: nem, életkor, osztály, családméret).

---

## Projekt felépítése

- `titanic.ipynb` - fő notebook – adatkezelés és modell
- `docs` mappa - a beadandók követelményei
- `titanic` mappa - Titanic adatfájl (Kaggle-ről)
- `setup_venv.bat` - virtuális környezetet létrehozó batch fájl:
    - Ellenőrzi, hogy létezik-e már a virtuális környezet
    - Ha nem létezik, létrehozza azt
    - Aktiválja a venv-et, és telepíti a szükséges csomagokat (`requirements.txt` fájl alapján)
    - Használathoz csak futtatni kell a batch fájlt
- `requirements.txt` - használt csomagok listája (numpy, pandas, matplotlib, scikit-learn, seaborn, tensorflow és függőségeik)
- `README.md` - ez a dokumentáció

---

## Fő lépések

### 1. Adatok betöltése
- `pandas` segítségével a `train.csv` fájl betöltése
- Adatok megtekintése (`head()`, `describe()`)

---

### 2. Hiányzó és kiugró értékek kezelése
- Hiányzó értékek elemzése
    - A hiányzó értékek vizsgálatánál észrevettem, hogy a `Cabin` oszlopban rengeteg adat (kb. 80%) hiányzik. Ezért ezt a feature-t eldobtam, nem használtam fel a modellben.
    - Az `Age` és `Fare` oszlopokban a hiányzó adatokat mediánnal pótoltam
    - Az `Embarked` oszlopban pedig a leggyakoribb kategóriával (módusz) pótoltam a hiányzó adatokat (`mode()`)
    - A hiányzó értékek pótlása során az eredeti `train` adathalmazt változatlanul hagytam, a feldolgozott változatot `train_new` néven tároltam el
- Felesleges adatok
    - a `PassengerId`, `Ticket` oszlopokat is eldobtam, nincs közük a túléléshez
- Outlierek elemzése
    - az `Age` és `Fare` oszlopokat vizsgáltam boxen plot segítségével
        - az `Age` oszlop teljesen rendben volt
        - a `Fare` oszlopban van kiugró érték (500 körül), de ezek elvileg valós első osztályú jegyárak, ezért nem lettek eltávolítva

---

### 3. Feature engineering

- Létrehoztam új feature-öket:
    - `FamilySize`:
        - `SibSp` + `Parch` + 1
        - `SibSp`: testvér(ek) és házastárs
        - `Parch`: szülő(k), gyerek(ek)
        - +1: maga az utas
    - `IsAlone`:
        - `FamilySize` feature szerint készítettem
        - ha a `FamilySize` = 1, akkor egyedül utazik
    - `Title`
        - A `Name` oszlopból regex kifejezés segítségével kinyertem a `Title`-t (titulust)
        - Ezután a `Name` oszlopot eldobtam, mert szerintem nem releváns a megoldásban
        - Erre később jöttem rá, de nagyon sok egyedi érték volt benne, ezért csináltam egy "Rare" kategóriát, és azokat tettem bele, amik 30-nál kevesebbszer fordulnak elő
        - Majd átalakítottam numerikussá (one-hot encoding)
    
- One-hot és label encoding:    
    - `Embarked`:
        - Hol szállt fel az utas
        - One-hot encoding-al numerikussá alakítottam (C,Q,S)
    - `Sex`:
        - label encoding: `map()`-el numerikussá alakítottam, mert a neu-hálónál nem tudta feldolgozni alapból

---

### 4. Standardizálás

- Az `Age`, `Fare` oszlopokat standardizáltam
    - Ez azért kellett, mert nagyon különböző skálán voltak (`Age` kb. 0–80, `Fare` kb. 0–500)

---

### 5. Adatok szétválasztása

- A `train` adatot használtam a modell tanítására: `x_train`, `y_train`
- A train adaton belül készítettem train/validation splitet (`train_test_split`)
    - `x_validation`, `y_validation`
- `stratify` paraméter:  megőrzi az osztályok arányát a train és validation halmazban
    - pl.: Survived (0/1) aránya ugyanolyan lesz mindkét halmazban

---

### @todo: 6. Baseline modell

- Egy egyszerű baseline modellként Logistic Regression modell használata
- Célja, hogy összehasonlítási alapot adjon a neurális háló teljesítményéhez

- Tanítás: u.a
- Validáció: u.a

- Eredmények:
    - Accuracy:
    - F1-score:

---

### 7. Modell – Neurális háló

- Használtam egy Sequential neurális hálót, több rejtett réteggel
    - Dense(16), Dense(8), Dense(4), Dense(1)
- Aktivációs függvények: 
    - ReLU a rejtett rétegeknél,
    - sigmoid a kimeneti rétegnél
- Optimalizáló: Adam, learning_rate=5e-4.
- Loss függvény: binary_crossentropy

---

### 8. Modell tanítása és értékelése

- Tanítás: `x_train`, `y_train`
- Validáció: `x_val`, `y_val`
- EarlyStopping: a val_loss monitorozásával, patience=25
- Batch méret: 32, epoch: 100.

---

### 9. Teljesítmény

- Validation accuracy: 80–85%
- Loss: 0.33–0.44 körül
- @todo: F1-score
- A tanulás alakulását grafikonon is vizualizáltam:
  - Loss alakulása az epoch-ok során
  - Pontosság alakulása az epoch-ok során

---

### @todo: 10. Modellek összehasonlítása

A baseline és a neurális háló teljesítményének összehasonlítása:

| Modell | Accuracy | F1-score |
|--------|----------|----------|
| Logistic Regression | | |
| Neurális háló | | |

Megfigyelhető, hogy ...

---

### 11. Predikáció és értékelés

- Teszt adatokon:
  - Confusion Matrix
  - ROC görbe és AUC
- A teszt pontossága: ~83%
- A ROC AUC: ~85%

---

### @todo: Következtetés

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
Neurális hálózatok beadandó 2026