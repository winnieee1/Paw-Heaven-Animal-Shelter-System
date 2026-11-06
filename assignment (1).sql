ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

DROP TABLE Prescription CASCADE CONSTRAINTS;
DROP TABLE HealthCheckup CASCADE CONSTRAINTS;
DROP TABLE Medication CASCADE CONSTRAINTS;
DROP TABLE OnDutyCaretaker CASCADE CONSTRAINTS;
DROP TABLE Caretaker CASCADE CONSTRAINTS;
DROP TABLE Animal CASCADE CONSTRAINTS;
DROP TABLE Vet CASCADE CONSTRAINTS;
DROP TABLE Species CASCADE CONSTRAINTS;
DROP TABLE Adopter CASCADE CONSTRAINTS;

-- Table 1: Adopter
CREATE TABLE Adopter (
    AdopterID CHAR(5) PRIMARY KEY CHECK (AdopterID LIKE 'A%'),
    IC VARCHAR2(20) UNIQUE NOT NULL,
    FirstName VARCHAR2(50) NOT NULL CHECK (FirstName = UPPER(FirstName)),
    LastName VARCHAR2(50) NOT NULL CHECK (LastName = UPPER(LastName)),
    AdpPhone VARCHAR2(20) NOT NULL CHECK (AdpPhone LIKE '0%-%'),
    Street VARCHAR2(100),
    City VARCHAR2(50),
    State VARCHAR2(50),
    AdoptionDate DATE DEFAULT SYSDATE 
);

-- Table 2: Species
CREATE TABLE Species (
    SpeciesID CHAR(5) PRIMARY KEY CHECK (SpeciesID LIKE 'S%'),
    SpeciesName VARCHAR2(50) NOT NULL
);

-- Table 3: Animal
CREATE TABLE Animal (
    AnimalID CHAR(5) PRIMARY KEY CHECK (AnimalID LIKE 'AN%'),
    AnimalName VARCHAR2(50) NOT NULL,
    Gender CHAR(1) NOT NULL CHECK (Gender IN ('M', 'F')),
    DOB DATE,
    ArrivalDate DATE NOT NULL,
    AdopterID CHAR(5) CHECK (AdopterID LIKE 'A%'),
    SpeciesID CHAR(5) NOT NULL CHECK (SpeciesID LIKE 'S%'),
    FOREIGN KEY (AdopterID) REFERENCES Adopter(AdopterID),
    FOREIGN KEY (SpeciesID) REFERENCES Species(SpeciesID)
);

-- Table 4: Caretaker
CREATE TABLE Caretaker (
    CaretakerID CHAR(5) PRIMARY KEY CHECK (CaretakerID LIKE 'C%'),
    FirstName VARCHAR2(50) NOT NULL,
    LastName VARCHAR2(50) NOT NULL,
    CtkPhone VARCHAR2(20) UNIQUE NOT NULL CHECK (CtkPhone LIKE '0%-%'),
    ShiftTime VARCHAR2(20)
);

-- Table 5: OnDutyCaretaker
CREATE TABLE OnDutyCaretaker (
    OndutyID CHAR(5) PRIMARY KEY CHECK (OndutyID LIKE 'O%'),
    StartTime DATE,
    EndTime DATE,
    DutyShift VARCHAR2(50),
    AnimalID CHAR(5) NOT NULL CHECK (AnimalID LIKE 'AN%'),
    CaretakerID CHAR(5) NOT NULL CHECK (CaretakerID LIKE 'C%'),
    FOREIGN KEY (AnimalID) REFERENCES Animal(AnimalID),
    FOREIGN KEY (CaretakerID) REFERENCES Caretaker(CaretakerID)
);

-- Table 6: Vet
CREATE TABLE Vet (
    VetID CHAR(5) PRIMARY KEY CHECK (VetID LIKE 'V%'),
    VetName VARCHAR2(50) NOT NULL,
    VetPhone VARCHAR2(20) UNIQUE NOT NULL CHECK (VetPhone LIKE '0%-%')
);

-- Table 7: HealthCheckup
CREATE TABLE HealthCheckup (
    HealthCheckupID CHAR(5) PRIMARY KEY CHECK (HealthCheckupID LIKE 'H%'),
    CheckupDate DATE,
    CheckupNotes VARCHAR2(500),
    HealthRating NUMBER(1) CHECK (HealthRating BETWEEN 1 AND 5),
    AnimalID CHAR(5) NOT NULL CHECK (AnimalID LIKE 'AN%'),
    VetID CHAR(5) NOT NULL CHECK (VetID LIKE 'V%'),
    FOREIGN KEY (AnimalID) REFERENCES Animal(AnimalID),
    FOREIGN KEY (VetID) REFERENCES Vet(VetID)
);

-- Table 8: Medication
CREATE TABLE Medication (
    MedicationID CHAR(5) PRIMARY KEY CHECK (MedicationID LIKE 'M%'),
    MedName VARCHAR2(50),
    MedType VARCHAR2(50) CHECK (MedType IN ('Pill', 'Topical', 'Syrup', 'Injection', 'Tablet')),
    MedPrice NUMBER(6,2),
    Dosage VARCHAR2(50)
);

-- Table 9: Prescription 
CREATE TABLE Prescription (
    HealthCheckupID CHAR(5) CHECK (HealthCheckupID LIKE 'H%'),
    MedicationID CHAR(5) CHECK (MedicationID LIKE 'M%'),
    DosageInstruction VARCHAR2(500),
    PRIMARY KEY (HealthCheckupID, MedicationID),
    FOREIGN KEY (HealthCheckupID) REFERENCES HealthCheckup(HealthCheckupID),
    FOREIGN KEY (MedicationID) REFERENCES Medication(MedicationID)
);

--Adopter data
INSERT INTO Adopter (AdopterID, IC, FirstName, LastName, AdpPhone, Street, City, State, AdoptionDate) VALUES ('A0001', '901215-08-1234', 'ZHI WEI, DAVID', 'YEO', '012-3816542', '23 Jalan Tun Perak', 'Kuala Lumpur', 'Wilayah Persekutuan', TO_DATE('2023-09-01','YYYY-MM-DD'));
INSERT INTO Adopter (AdopterID, IC, FirstName, LastName, AdpPhone, Street, City, State, AdoptionDate) VALUES ('A0002', '010304-05-5678', 'ALI', 'BIN MOHD HASSAN', '015-5552143', '15 Jalan Raja Musa Aziz', 'Ipoh', 'Perak', TO_DATE('2024-07-10', 'YYYY-MM-DD'));
INSERT INTO Adopter (AdopterID, IC, FirstName, LastName, AdpPhone, Street, City, State, AdoptionDate) VALUES ('A0003', '920720-10-9876', 'LEE', 'XIN YAO', '016-9876544', '41 Jalan Tuanku Munawir','Seremban', 'Negeri Sembilan', TO_DATE('2025-06-20', 'YYYY-MM-DD'));
INSERT INTO Adopter (AdopterID, IC, FirstName, LastName, AdpPhone, Street, City, State, AdoptionDate) VALUES ('A0004', '880815-07-2468', 'PRIYA', 'A/P MUTHU', '019-2468102', '36 Jalan Dato Sulaiman', 'Johor Bahru', 'Johor', TO_DATE('2024-03-20', 'YYYY-MM-DD'));
INSERT INTO Adopter (AdopterID, IC, FirstName, LastName, AdpPhone, Street, City, State, AdoptionDate) VALUES ('A0005', '990622-12-1357', 'FATIMAH', 'BINTI OMAR', '018-1357913', '58 Jalan Teluk Sisek', 'Kuantan', 'Pahang', TO_DATE('2024-08-20', 'YYYY-MM-DD'));
INSERT INTO Adopter (AdopterID, IC, FirstName, LastName, AdpPhone, Street, City, State, AdoptionDate) VALUES ('A0006', '030908-03-2288', 'MARIAM', 'BINTI YUSOF', '013-2288799', '14 Jalan Sri Gombak 2', 'Batu Caves', 'Selangor', TO_DATE('2023-12-17', 'YYYY-MM-DD'));
INSERT INTO Adopter (AdopterID, IC, FirstName, LastName, AdpPhone, Street, City, State, AdoptionDate) VALUES ('A0007', '870405-11-2268', 'YAN LING, SARAH', 'HO', '014-2268900', '55 Jalan Kuchai Lama', 'Kuala Lumpur', 'Wilayah Persekutuan', TO_DATE('2024-09-25', 'YYYY-MM-DD'));
INSERT INTO Adopter (AdopterID, IC, FirstName, LastName, AdpPhone, Street, City, State, AdoptionDate) VALUES ('A0008', '931010-14-3862', 'VIKRAM', 'A/L SUBRAMANIAM', '012-3862830', '10 Jalan Subang', 'Subang Jaya', 'Selangor', TO_DATE('2024-11-25', 'YYYY-MM-DD'));

--species data
INSERT INTO Species (SpeciesID, SpeciesName) VALUES ('S0001', 'Dog');
INSERT INTO Species (SpeciesID, SpeciesName) VALUES ('S0002', 'Cat');
INSERT INTO Species (SpeciesID, SpeciesName) VALUES ('S0003', 'Rabbit');
INSERT INTO Species (SpeciesID, SpeciesName) VALUES ('S0004', 'Bird');
INSERT INTO Species (SpeciesID, SpeciesName) VALUES ('S0005', 'Guinea Pig');
INSERT INTO Species (SpeciesID, SpeciesName) VALUES ('S0006', 'Hamster');
INSERT INTO Species (SpeciesID, SpeciesName) VALUES ('S0007', 'Chinchilla');
INSERT INTO Species (SpeciesID, SpeciesName) VALUES ('S0008', 'Parakeet');

--Animal data
INSERT INTO Animal (AnimalID, AnimalName, Gender, DOB, ArrivalDate, AdopterID, SpeciesID) VALUES ('AN001', 'Bob', 'M', TO_DATE('2022-10-15','YYYY-MM-DD'), TO_DATE('2023-04-28','YYYY-MM-DD'), 'A0001', 'S0001');
INSERT INTO Animal (AnimalID, AnimalName, Gender, DOB, ArrivalDate, AdopterID, SpeciesID) VALUES ('AN002', 'Whiskers', 'M', TO_DATE('2023-02-12','YYYY-MM-DD'), TO_DATE('2023-06-01','YYYY-MM-DD'), 'A0002', 'S0002');
INSERT INTO Animal (AnimalID, AnimalName, Gender, DOB, ArrivalDate, AdopterID, SpeciesID) VALUES ('AN003', 'Max', 'F', TO_DATE('2023-03-20','YYYY-MM-DD'), TO_DATE('2024-03-17','YYYY-MM-DD'), NULL, 'S0004');
INSERT INTO Animal (AnimalID, AnimalName, Gender, DOB, ArrivalDate, AdopterID, SpeciesID) VALUES ('AN004', 'Bella', 'F', TO_DATE('2022-12-01', 'YYYY-MM-DD'), TO_DATE('2024-01-15', 'YYYY-MM-DD'), 'A0004', 'S0003');
INSERT INTO Animal (AnimalID, AnimalName, Gender, DOB, ArrivalDate, AdopterID, SpeciesID) VALUES ('AN005', 'Charlie', 'M', TO_DATE('2023-10-01','YYYY-MM-DD'), TO_DATE('2023-12-28','YYYY-MM-DD'), 'A0005', 'S0002');
INSERT INTO Animal (AnimalID, AnimalName, Gender, DOB, ArrivalDate, AdopterID, SpeciesID) VALUES ('AN006', 'Daisy', 'F', TO_DATE('2023-03-10','YYYY-MM-DD'), TO_DATE('2023-11-01','YYYY-MM-DD'), 'A0006','S0004');
INSERT INTO Animal (AnimalID, AnimalName, Gender, DOB, ArrivalDate, AdopterID, SpeciesID) VALUES ('AN007', 'Oscar', 'M', TO_DATE('2023-05-05','YYYY-MM-DD'), TO_DATE('2024-06-27','YYYY-MM-DD'), NULL, 'S0005');
INSERT INTO Animal (AnimalID, AnimalName, Gender, DOB, ArrivalDate, AdopterID, SpeciesID) VALUES ('AN008', 'Rosie', 'F', TO_DATE('2022-08-20','YYYY-MM-DD'), TO_DATE('2024-01-15','YYYY-MM-DD'), 'A0008', 'S0006');
INSERT INTO Animal (AnimalID, AnimalName, Gender, DOB, ArrivalDate, AdopterID, SpeciesID) VALUES ('AN009', 'Nemo', 'M', TO_DATE('2024-11-08', 'YYYY-MM-DD'), TO_DATE('2025-02-25','YYYY-MM-DD'), 'A0003', 'S0001');
INSERT INTO Animal (AnimalID, AnimalName, Gender, DOB, ArrivalDate, AdopterID, SpeciesID) VALUES ('AN010', 'Gizmo', 'F', TO_DATE('2023-04-18', 'YYYY-MM-DD'), TO_DATE('2024-07-12','YYYY-MM-DD'), 'A0008', 'S0007');
INSERT INTO Animal (AnimalID, AnimalName, Gender, DOB, ArrivalDate, AdopterID, SpeciesID) VALUES ('AN011', 'Sparky', 'M', TO_DATE('2023-07-01','YYYY-MM-DD'), TO_DATE('2024-12-30','YYYY-MM-DD'), NULL, 'S0001');
INSERT INTO Animal (AnimalID, AnimalName, Gender, DOB, ArrivalDate, AdopterID, SpeciesID) VALUES ('AN012', 'Peach', 'F', TO_DATE('2024-09-17','YYYY-MM-DD'), TO_DATE('2025-01-10','YYYY-MM-DD'), NULL, 'S0003');
INSERT INTO Animal (AnimalID, AnimalName, Gender, DOB, ArrivalDate, AdopterID, SpeciesID) VALUES ('AN013', 'Shadow', 'M', TO_DATE('2022-11-15','YYYY-MM-DD'), TO_DATE('2024-05-20','YYYY-MM-DD'), 'A0007', 'S0006');
INSERT INTO Animal (AnimalID, AnimalName, Gender, DOB, ArrivalDate, AdopterID, SpeciesID) VALUES ('AN014', 'Luna', 'F', TO_DATE('2023-05-28','YYYY-MM-DD'), TO_DATE('2024-06-20','YYYY-MM-DD'), 'A0005', 'S0002');

--CARETAKER DATA
INSERT INTO Caretaker (CaretakerID, FirstName, LastName, CtkPhone, ShiftTime) VALUES ('C0001', 'Wong', 'Jun Hao', '011-1160899', '06:00-14:00');
INSERT INTO Caretaker (CaretakerID, FirstName, LastName, CtkPhone, ShiftTime) VALUES ('C0002', 'Xiao Hui, Laura', 'Lim', '019-2573894', '06:00-14:00');
INSERT INTO Caretaker (CaretakerID, FirstName, LastName, CtkPhone, ShiftTime) VALUES ('C0003', 'Siti Nurhaliza', 'Binti Hassan', '013-4569362', '14:00-22:00');
INSERT INTO Caretaker (CaretakerID, FirstName, LastName, CtkPhone, ShiftTime) VALUES ('C0004', 'Rajesh', 'A/L Kumar Patel', '016-4207490', '14:00-22:00');
INSERT INTO Caretaker (CaretakerID, FirstName, LastName, CtkPhone, ShiftTime) VALUES ('C0005', 'Chen', 'Mei Ling', '012-9374999', '22:00-06:00');
INSERT INTO Caretaker (CaretakerID, FirstName, LastName, CtkPhone, ShiftTime) VALUES ('C0006', 'Tan', 'Zi Heng', '017-8364098', '22:00-06:00');
INSERT INTO Caretaker (CaretakerID, FirstName, LastName, CtkPhone, ShiftTime) VALUES ('C0007', 'Fariz Haikal', 'Bin Omar', '015-6452046', '06:00-14:00');
INSERT INTO Caretaker (CaretakerID, FirstName, LastName, CtkPhone, ShiftTime) VALUES ('C0008', 'Ahmad Firdaus', 'Bin Ibrahim', '014-1239643', '22:00-06:00');

--ONDUTYCARETAKER DATA
INSERT INTO OnDutyCaretaker (OndutyID, StartTime, EndTime, DutyShift, AnimalID, CaretakerID) VALUES ('O0001', TO_DATE('2023-05-01 06:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2024-05-01 14:00', 'YYYY-MM-DD HH24:MI'), 'Morning Shift', 'AN001', 'C0001');
INSERT INTO OnDutyCaretaker (OndutyID, StartTime, EndTime, DutyShift, AnimalID, CaretakerID) VALUES ('O0002', TO_DATE('2024-04-22 22:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2024-04-23 06:00', 'YYYY-MM-DD HH24:MI'), 'Evening Shift', 'AN003', 'C0005');
INSERT INTO OnDutyCaretaker (OndutyID, StartTime, EndTime, DutyShift, AnimalID, CaretakerID) VALUES ('O0003', TO_DATE('2024-12-12 14:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2024-12-12 22:00', 'YYYY-MM-DD HH24:MI'), 'Afternoon Shift', 'AN002', 'C0003');
INSERT INTO OnDutyCaretaker (OndutyID, StartTime, EndTime, DutyShift, AnimalID, CaretakerID) VALUES ('O0004', TO_DATE('2024-02-18 14:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2024-02-18 22:00', 'YYYY-MM-DD HH24:MI'), 'Afternoon Shift', 'AN004', 'C0004');
INSERT INTO OnDutyCaretaker (OndutyID, StartTime, EndTime, DutyShift, AnimalID, CaretakerID) VALUES ('O0005', TO_DATE('2024-01-01 06:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2024-01-01 14:00', 'YYYY-MM-DD HH24:MI'), 'Morning Shift', 'AN005', 'C0002');
INSERT INTO OnDutyCaretaker (OndutyID, StartTime, EndTime, DutyShift, AnimalID, CaretakerID) VALUES ('O0006', TO_DATE('2025-03-11 06:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2025-03-11 14:00', 'YYYY-MM-DD HH24:MI'), 'Morning Shift', 'AN011', 'C0007');
INSERT INTO OnDutyCaretaker (OndutyID, StartTime, EndTime, DutyShift, AnimalID, CaretakerID) VALUES ('O0007', TO_DATE('2024-11-10 22:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2024-11-11 06:00', 'YYYY-MM-DD HH24:MI'), 'Evening Shift', 'AN007', 'C0008');
INSERT INTO OnDutyCaretaker (OndutyID, StartTime, EndTime, DutyShift, AnimalID, CaretakerID) VALUES ('O0008', TO_DATE('2024-09-01 22:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2024-09-02 06:00', 'YYYY-MM-DD HH24:MI'), 'Evening Shift', 'AN010', 'C0005');
INSERT INTO OnDutyCaretaker (OndutyID, StartTime, EndTime, DutyShift, AnimalID, CaretakerID) VALUES ('O0009', TO_DATE('2024-07-28 14:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2024-07-28 22:00', 'YYYY-MM-DD HH24:MI'), 'Afternoon Shift', 'AN014', 'C0004');
INSERT INTO OnDutyCaretaker (OndutyID, StartTime, EndTime, DutyShift, AnimalID, CaretakerID) VALUES ('O0010', TO_DATE('2024-10-15 22:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2024-10-16 06:00', 'YYYY-MM-DD HH24:MI'), 'Evening Shift', 'AN008', 'C0006');
INSERT INTO OnDutyCaretaker (OndutyID, StartTime, EndTime, DutyShift, AnimalID, CaretakerID) VALUES ('O0011', TO_DATE('2023-11-09 06:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2023-11-09 14:00', 'YYYY-MM-DD HH24:MI'), 'Morning Shift', 'AN006', 'C0001');
INSERT INTO OnDutyCaretaker (OndutyID, StartTime, EndTime, DutyShift, AnimalID, CaretakerID) VALUES ('O0012', TO_DATE('2025-02-09 14:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2025-02-09 22:00', 'YYYY-MM-DD HH24:MI'), 'Afternoon Shift', 'AN012', 'C0003');
INSERT INTO OnDutyCaretaker (OndutyID, StartTime, EndTime, DutyShift, AnimalID, CaretakerID) VALUES ('O0013', TO_DATE('2024-06-23 06:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2024-06-23 14:00', 'YYYY-MM-DD HH24:MI'), 'Morning Shift', 'AN013', 'C0002');
INSERT INTO OnDutyCaretaker (OndutyID, StartTime, EndTime, DutyShift, AnimalID, CaretakerID) VALUES ('O0014', TO_DATE('2025-03-09 22:00', 'YYYY-MM-DD HH24:MI'), TO_DATE('2025-03-10 06:00', 'YYYY-MM-DD HH24:MI'), 'Evening Shift', 'AN009', 'C0008');

---VET DATA
INSERT INTO Vet (VetID, VetName, VetPhone) VALUES ('V0001', 'Dr. Lee Hao Ran', '013-9876543');
INSERT INTO Vet (VetID, VetName, VetPhone) VALUES ('V0002', 'Dr. Nur Aisyah Binti Ahmad ', '014-7654321');
INSERT INTO Vet (VetID, VetName, VetPhone) VALUES ('V0003', 'Dr. Michelle Tan Mei Ling', '015-6543210');
INSERT INTO Vet (VetID, VetName, VetPhone) VALUES ('V0004', 'Dr. Alex Wong Zhen Yi', '016-5432109');
INSERT INTO Vet (VetID, VetName, VetPhone) VALUES ('V0005', 'Dr. Ho Yan Bing', '017-4321098');
INSERT INTO Vet (VetID, VetName, VetPhone) VALUES ('V0006', 'Dr. Sanjana A/P Sharma', '018-3210987');
INSERT INTO Vet (VetID, VetName, VetPhone) VALUES ('V0007', 'Dr. Sita A/P Patel', '019-2109876');
INSERT INTO Vet (VetID, VetName, VetPhone) VALUES ('V0008', 'Dr. Azman Bin Sulong', '013-1098765');


---HEALTHCHECKUP DATA
INSERT INTO HealthCheckup (HealthCheckupID, CheckupDate, CheckupNotes, HealthRating, AnimalID, VetID) VALUES ('H0001', TO_DATE('2024-05-01', 'YYYY-MM-DD'), 'Patient presented with mild lethargy and decreased appetite for 3 days. Physical exam reveals normal temperature (101.2°F), heart rate 90 bpm. Slight dehydration noted. Lymph nodes normal. Recommended increased water intake and monitoring. Weight: 12.3kg', 3, 'AN003', 'V0001');
INSERT INTO HealthCheckup (HealthCheckupID, CheckupDate, CheckupNotes, HealthRating, AnimalID, VetID) VALUES ('H0002', TO_DATE('2024-12-15', 'YYYY-MM-DD'), 'Annual vaccination visit. Patient showing signs of flea infestation - excessive scratching, red irritated skin on hindquarters. Multiple flea dirt particles observed during examination. Administered DHPP vaccine and applied topical flea treatment. Owner advised on environmental flea control measures. Weight: 8.7kg', 3, 'AN007', 'V0002');
INSERT INTO HealthCheckup (HealthCheckupID, CheckupDate, CheckupNotes, HealthRating, AnimalID, VetID) VALUES ('H0003', TO_DATE('2025-01-12', 'YYYY-MM-DD'), 'Emergency presentation - patient found unresponsive by caretaker. Signs of possible toxin ingestion, dilated pupils, elevated heart rate (140 bpm), hypersalivation. Gastric lavage performed, activated charcoal administered. Patient stabilized after 4 hours of intensive care. Blood work shows elevated liver enzymes. Requires close monitoring for 72 hours.', 5, 'AN012', 'V0001');
INSERT INTO HealthCheckup (HealthCheckupID, CheckupDate, CheckupNotes, HealthRating, AnimalID, VetID) VALUES ('H0004', TO_DATE('2023-07-20', 'YYYY-MM-DD'), 'Patient presented with acute vomiting (4 episodes in 12 hours), diarrhea, and refusal to eat. Temperature elevated at 103.1°F. Abdomen tender on palpation, possible gastroenteritis. Dehydration assessed at 6%. IV fluids initiated. Fecal examination negative for parasites. Prescribed anti-nausea medication and bland diet. Weight loss of 0.8kg since last visit.', 5, 'AN001', 'V0003');
INSERT INTO HealthCheckup (HealthCheckupID, CheckupDate, CheckupNotes, HealthRating, AnimalID, VetID) VALUES ('H0005', TO_DATE('2024-11-12', 'YYYY-MM-DD'), 'Excellent overall health status. Bright, alert, and responsive. Normal vital signs: temperature 100.8°F, heart rate 85 bpm, respiratory rate 22/min. Body condition score 4/5 - ideal weight maintained. Dental health good with minimal tartar buildup. Eyes clear, ears clean. No concerns noted. Continue current diet and exercise routine.', 4, 'AN007', 'V0004');
INSERT INTO HealthCheckup (HealthCheckupID, CheckupDate, CheckupNotes, HealthRating, AnimalID, VetID) VALUES ('H0006', TO_DATE('2023-11-05', 'YYYY-MM-DD'), 'Annual wellness examination. Patient cooperative during handling. Heart murmur grade 2/6 detected - recommend cardiac evaluation. Otherwise normal physical findings. Current weight 4.2kg, slight increase from last year. Dental cleaning recommended due to moderate tartar accumulation. Blood panel shows normal kidney and liver function. Updated on all core vaccines.', 3, 'AN006', 'V0002');
INSERT INTO HealthCheckup (HealthCheckupID, CheckupDate, CheckupNotes, HealthRating, AnimalID, VetID) VALUES ('H0007', TO_DATE('2024-01-28', 'YYYY-MM-DD'), 'Chronic skin condition evaluation. Patient shows signs of environmental allergies - red, inflamed skin between toes, excessive licking of paws, hair loss on ventral abdomen. Skin scraping negative for mites. Intradermal allergy testing performed - positive reactions to dust mites and grass pollen. Initiated hypoallergenic diet trial and prescribed antihistamines.', 2, 'AN005', 'V0005');
INSERT INTO HealthCheckup (HealthCheckupID, CheckupDate, CheckupNotes, HealthRating, AnimalID, VetID) VALUES ('H0008', TO_DATE('2024-08-25', 'YYYY-MM-DD'), 'Pre-adoption health screening. Patient in excellent condition - active, playful, well-socialized. All vital parameters within normal limits. Body condition optimal at 3.5/5. Fecal examination clear, no parasites detected. Vaccinations up to date including rabies. Microchip implanted successfully. Ready for adoption placement. Weight: 2.1kg', 5, 'AN008', 'V0008');
INSERT INTO HealthCheckup (HealthCheckupID, CheckupDate, CheckupNotes, HealthRating, AnimalID, VetID) VALUES ('H0009', TO_DATE('2025-03-01', 'YYYY-MM-DD'), 'Severe upper respiratory infection. Patient presenting with thick nasal discharge (purulent), difficulty breathing, lethargy, and anorexia for 5 days. Temperature 104.2°F indicating fever. Chest X-rays show mild pneumonia in right lung. Bacterial culture pending. Started on broad-spectrum antibiotics and supportive care. Isolation protocols implemented due to contagious nature.', 1, 'AN009', 'V0004');
INSERT INTO HealthCheckup (HealthCheckupID, CheckupDate, CheckupNotes, HealthRating, AnimalID, VetID) VALUES ('H0010', TO_DATE('2024-06-22', 'YYYY-MM-DD'), 'Routine deworming appointment. Fecal examination revealed moderate roundworm infestation. Patient otherwise healthy with good appetite and normal activity levels. No other parasites detected. Administered anthelmintic treatment and scheduled follow-up fecal check in 2 weeks. Discussed prevention strategies with caretakers. Weight stable at 1.8kg', 4, 'AN013', 'V0001');
INSERT INTO HealthCheckup (HealthCheckupID, CheckupDate, CheckupNotes, HealthRating, AnimalID, VetID) VALUES ('H0011', TO_DATE('2024-10-03', 'YYYY-MM-DD'), 'Six-month wellness check. Patient showing good adaptation to shelter environment. Minor behavioral concerns noted - some food guarding behavior observed. Physical examination unremarkable except for slightly overgrown nails requiring trimming. Dental health fair with some plaque buildup. Socialization training recommended to address behavioral issues. Overall stable condition.', 3, 'AN011', 'V0008');
INSERT INTO HealthCheckup (HealthCheckupID, CheckupDate, CheckupNotes, HealthRating, AnimalID, VetID) VALUES ('H0012', TO_DATE('2025-06-18', 'YYYY-MM-DD'), 'Mandatory rabies vaccination and health certificate for adoption. Patient exhibited high stress levels during examination - panting, trembling, attempting to hide. Physical exam challenging due to anxiety. Prescribed mild sedative for future visits. No obvious health concerns detected despite stressed presentation. Vaccination administered successfully. Anti-anxiety protocols recommended.', 2, 'AN012', 'V0007');
INSERT INTO HealthCheckup (HealthCheckupID, CheckupDate, CheckupNotes, HealthRating, AnimalID, VetID) VALUES ('H0013', TO_DATE('2024-07-14', 'YYYY-MM-DD'), 'Post-adoption follow-up examination. Patient showing excellent adaptation to new home environment. Owner reports good appetite, regular elimination, and playful behavior. Physical exam reveals healthy coat condition, bright eyes, and normal body condition score 4/5. Minor dental tartar noted but within normal limits for age. Weight increased appropriately from 1.6kg to 1.9kg since arrival. No behavioral concerns reported. Vaccination boosters administered.', 4, 'AN013', 'V0001');
INSERT INTO HealthCheckup (HealthCheckupID, CheckupDate, CheckupNotes, HealthRating, AnimalID, VetID) VALUES ('H0014', TO_DATE('2024-05-12', 'YYYY-MM-DD'), 'Spay surgery pre-operative examination and post-operative check. Patient presented in good health for routine spaying procedure. Pre-surgical bloodwork normal - liver and kidney function within parameters. Surgery completed without complications. Post-op recovery excellent - incision healing well with no signs of infection or dehiscence. Patient alert and eating normally. Suture removal scheduled for 10-14 days. Owner compliance with post-surgical restrictions good. Weight: 3.8kg', 3, 'AN014', 'V0005');


--MEDICATION DATA
INSERT INTO Medication (MedicationID, MedName, MedType, MedPrice, Dosage) VALUES ('M0001', 'Heartworm Prevention', 'Pill', 55.00, 'Based on body weight');
INSERT INTO Medication (MedicationID, MedName, MedType, MedPrice, Dosage) VALUES ('M0002', 'Flea Control', 'Topical', 32.50, 'Apply once monthly');
INSERT INTO Medication (MedicationID, MedName, MedType, MedPrice, Dosage) VALUES ('M0003', 'Antibiotics', 'Syrup', 45.75, '10ml twice a day');
INSERT INTO Medication (MedicationID, MedName, MedType, MedPrice, Dosage) VALUES ('M0004', 'Pain Relief', 'Injection', 60.00, '0.1ml/kg every 12 hours');
INSERT INTO Medication (MedicationID, MedName, MedType, MedPrice, Dosage) VALUES ('M0005', 'Dewormer', 'Pill', 25.00, '25mg daily');
INSERT INTO Medication (MedicationID, MedName, MedType, MedPrice, Dosage) VALUES ('M0006', 'Vitamin Boost', 'Syrup', 38.90, '15ml once a day');
INSERT INTO Medication (MedicationID, MedName, MedType, MedPrice, Dosage) VALUES ('M0007', 'Skin Cream', 'Topical', 22.00, '20g as needed');
INSERT INTO Medication (MedicationID, MedName, MedType, MedPrice, Dosage) VALUES ('M0008', 'Calming Supplement', 'Tablet', 41.25, '1 tablet daily');


--PRESCRIPTION DATA
INSERT INTO Prescription (HealthCheckupID, MedicationID, DosageInstruction) VALUES ('H0001', 'M0001', 'Take 1 pill daily for heartworm prevention, continue monitoring appetite and energy levels');
INSERT INTO Prescription (HealthCheckupID, MedicationID, DosageInstruction) VALUES ('H0002', 'M0002', 'Apply 10ml topical flea treatment once weekly, vacuum environment daily for 2 weeks');
INSERT INTO Prescription (HealthCheckupID, MedicationID, DosageInstruction) VALUES ('H0003', 'M0003', 'Give 5ml antibiotic syrup twice daily until finished, monitor for signs of liver dysfunction');
INSERT INTO Prescription (HealthCheckupID, MedicationID, DosageInstruction) VALUES ('H0004', 'M0004', 'Inject 2ml pain relief every 8 hours for 3 days, reduce to twice daily if improvement seen');
INSERT INTO Prescription (HealthCheckupID, MedicationID, DosageInstruction) VALUES ('H0005', 'M0005', 'Take 1 deworming pill every morning and evening for 5 days, repeat in 2 weeks');
INSERT INTO Prescription (HealthCheckupID, MedicationID, DosageInstruction) VALUES ('H0006', 'M0006', 'Take 15ml vitamin supplement daily for 7 days to support cardiac function');
INSERT INTO Prescription (HealthCheckupID, MedicationID, DosageInstruction) VALUES ('H0007', 'M0007', 'Apply skin cream to affected areas 2-3 times daily, continue hypoallergenic diet');
INSERT INTO Prescription (HealthCheckupID, MedicationID, DosageInstruction) VALUES ('H0008', 'M0008', 'Give 1 calming tablet daily before bed if stress behaviors persist');
INSERT INTO Prescription (HealthCheckupID, MedicationID, DosageInstruction) VALUES ('H0009', 'M0003', 'Take 1 heartworm prevention pill daily for 14 days as respiratory support');
INSERT INTO Prescription (HealthCheckupID, MedicationID, DosageInstruction) VALUES ('H0010', 'M0007', 'Apply 15ml topical treatment every 3 days to prevent secondary skin infections');
INSERT INTO Prescription (HealthCheckupID, MedicationID, DosageInstruction) VALUES ('H0011', 'M0003', 'Take 10ml antibiotic syrup every 6 hours until behavioral and physical improvement noted');
INSERT INTO Prescription (HealthCheckupID, MedicationID, DosageInstruction) VALUES ('H0012', 'M0004', 'Inject 1ml pain relief every 12 hours for 5 days to manage vaccination site soreness');
INSERT INTO Prescription (HealthCheckupID, MedicationID, DosageInstruction) VALUES ('H0013', 'M0006', 'Give 15ml vitamin supplement daily for 10 days to support immune system during transition period');
INSERT INTO Prescription (HealthCheckupID, MedicationID, DosageInstruction) VALUES ('H0014', 'M0004', 'Inject 2ml pain relief twice daily for 5 days post-surgery, then as needed for comfort');

SELECT * FROM Adopter;
SELECT * FROM Species;
SELECT * FROM Animal;
SELECT * FROM Caretaker;
SELECT * FROM OndutyCaretaker;
SELECT * FROM Vet;
SELECT * FROM HealthCheckup;
SELECT * FROM Medication;
SELECT * FROM Prescription;


--Query
-- a. A query that requires an outer join.
SELECT a.AnimalID, a.AnimalName, s.SpeciesName, a.Gender, a.ArrivalDate, 
    ad.FirstName, ad.LastName, ad.AdpPhone, ad.AdoptionDate
FROM Animal a
LEFT OUTER JOIN Adopter ad ON a.AdopterID = ad.AdopterID
JOIN Species s ON a.SpeciesID = s.SpeciesID
ORDER BY a.ArrivalDate DESC;
-- This query lists all animals along with their species and adopter details.
-- Animals without adopters are still included, showing NULL in adopter columns.


-- b. A minimum 4 table join with a group by function query.
SELECT a.AnimalID, a.AnimalName, SUM(m.MedPrice) AS TotalMedicationCost
FROM Animal a
JOIN HealthCheckup hc ON a.AnimalID = hc.AnimalID
JOIN Prescription p ON hc.HealthCheckupID = p.HealthCheckupID
JOIN Medication m ON p.MedicationID = m.MedicationID
GROUP BY a.AnimalID, a.AnimalName
ORDER BY TotalMedicationCost DESC;
-- This query calculates the total medication cost per animal which is useful for analyzing medical expenses per animal.


-- c. A string pattern matching and date function query.
SELECT hc.HealthCheckupID, hc.CheckupDate, hc.CheckupNotes, a.AnimalName
FROM HealthCheckup hc
JOIN Animal a ON hc.AnimalID = a.AnimalID
WHERE (LOWER(hc.CheckupNotes) LIKE '%vaccination%' OR LOWER(hc.CheckupNotes) LIKE '%vaccine%')
AND hc.CheckupDate >= ADD_MONTHS(SYSDATE, -12);
-- This query finds all health checkups in the past year where notes mention 'vaccine' or 'vaccination'.
-- This helps identify animals that received vaccinations recently.


--d. A query having both OR and AND
SELECT hc.HealthCheckupID, a.AnimalName, s.SpeciesName, hc.CheckupDate, hc.CheckupNotes FROM HealthCheckup hc
JOIN Animal a ON hc.AnimalID = a.AnimalID
JOIN Species s ON a.SpeciesID = s.SpeciesID
WHERE (s.SpeciesName = 'Cat' AND hc.CheckupDate > TO_DATE('2024-01-01', 'YYYY-MM-DD')) OR a.AnimalName = 'Bob';
-- This query identifies cats with recent health checkups and animals named BOB. While cats are monitored as part of regular preventive care,
-- the name BOB is used to track a past high-risk medical case. Combining both criteria helps ensure vulnerable animals receive timely follow-up.


--e. A query that consists of at least 2 subqueries
SELECT a.AnimalName, s.SpeciesName, (
    SELECT MIN(odc.StartTime) FROM OnDutyCaretaker odc
    WHERE odc.AnimalID = a.AnimalID
) AS FirstCareTime FROM Animal a
JOIN Species s ON a.SpeciesID = s.SpeciesID
WHERE a.AnimalID IN (
    SELECT hc.AnimalID FROM HealthCheckup hc
    WHERE hc.CheckupDate > SYSDATE - 365
)
AND a.AnimalID IN (
    SELECT odc.AnimalID FROM OnDutyCaretaker odc
    JOIN Caretaker c ON odc.CaretakerID = c.CaretakerID
    WHERE c.ShiftTime = '22:00-06:00'
);
-- This query identifies animals that received health checkups within the past year and were cared for by night-shift staff. 
-- It helps assess whether current overnight support is sufficient for animals with recent medical needs, guiding improvements in 
-- staffing or care procedures.


--f. List the animals that have been in the sanctuary for over a year and have received the 
--   most positive health check ratings for health studies
SELECT a.AnimalID, a.AnimalName, a.ArrivalDate, hc.HealthRating FROM Animal a
JOIN HealthCheckup hc ON a.AnimalID = hc.AnimalID
WHERE a.ArrivalDate <= SYSDATE - 365
AND hc.HealthRating = (
    SELECT MAX(HealthRating) FROM HealthCheckup
);
-- This query identifies animals that have stayed in the sanctuary for over a year and consistently received the most positive 
-- health check ratings. It helps caretakers and veterinarians monitor long-term residents’ well-being and recognize 
-- successful rehabilitation cases, which is essential for planning future adoption or specialized care efforts.