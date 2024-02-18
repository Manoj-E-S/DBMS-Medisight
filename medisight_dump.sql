-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
--
-- Host: localhost    Database: medisight
-- ------------------------------------------------------
-- Server version	8.0.36-0ubuntu0.22.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary view structure for view `DiseaseDetails`
--

DROP TABLE IF EXISTS `DiseaseDetails`;
/*!50001 DROP VIEW IF EXISTS `DiseaseDetails`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `DiseaseDetails` AS SELECT 
 1 AS `disease_id`,
 1 AS `disease_name`,
 1 AS `disease_desc`,
 1 AS `department_name`,
 1 AS `symptom_name`,
 1 AS `test_name`,
 1 AS `doctor_name`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `departments`
--

DROP TABLE IF EXISTS `departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departments` (
  `department_id` int NOT NULL AUTO_INCREMENT,
  `department_name` varchar(500) NOT NULL,
  PRIMARY KEY (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departments`
--

LOCK TABLES `departments` WRITE;
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` VALUES (2,'Oncology'),(3,'Cardiology'),(4,'Gastroenterology'),(5,'Urology'),(6,'Gynecology'),(7,'Pulmonology'),(8,'Dermatology'),(9,'Hematology'),(10,'Orthopedics'),(11,'Endocrinology');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `diseaseSymptoms`
--

DROP TABLE IF EXISTS `diseaseSymptoms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `diseaseSymptoms` (
  `disease_id` int NOT NULL,
  `symptom_id` int NOT NULL,
  PRIMARY KEY (`disease_id`,`symptom_id`),
  KEY `symptom_id` (`symptom_id`),
  CONSTRAINT `diseaseSymptoms_ibfk_1` FOREIGN KEY (`disease_id`) REFERENCES `diseases` (`disease_id`),
  CONSTRAINT `diseaseSymptoms_ibfk_2` FOREIGN KEY (`symptom_id`) REFERENCES `symptoms` (`symptom_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `diseaseSymptoms`
--

LOCK TABLES `diseaseSymptoms` WRITE;
/*!40000 ALTER TABLE `diseaseSymptoms` DISABLE KEYS */;
INSERT INTO `diseaseSymptoms` VALUES (1,1),(1,2),(1,3),(1,4),(2,5),(2,6),(2,7),(2,8),(3,8),(5,8),(6,8),(8,8),(2,9),(3,10),(5,10),(3,11),(3,12),(4,13),(4,14),(4,15),(4,16),(5,16),(9,16),(5,17),(5,18),(6,19),(6,20),(6,21),(7,22),(7,23),(7,24),(8,25),(8,26),(8,27),(8,28),(9,29),(9,30),(9,31),(10,32),(10,33),(10,34),(10,35);
/*!40000 ALTER TABLE `diseaseSymptoms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `diseaseTests`
--

DROP TABLE IF EXISTS `diseaseTests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `diseaseTests` (
  `disease_id` int NOT NULL,
  `test_id` int NOT NULL,
  PRIMARY KEY (`disease_id`,`test_id`),
  KEY `test_id` (`test_id`),
  CONSTRAINT `diseaseTests_ibfk_1` FOREIGN KEY (`disease_id`) REFERENCES `diseases` (`disease_id`),
  CONSTRAINT `diseaseTests_ibfk_2` FOREIGN KEY (`test_id`) REFERENCES `tests` (`test_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `diseaseTests`
--

LOCK TABLES `diseaseTests` WRITE;
/*!40000 ALTER TABLE `diseaseTests` DISABLE KEYS */;
INSERT INTO `diseaseTests` VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10),(1,11),(2,12),(1,13),(1,14),(2,14),(3,14),(4,14),(7,14),(8,14),(9,14),(10,14),(3,15),(8,16),(8,17),(1,18),(2,18),(3,18),(7,18),(8,18),(9,18),(10,18),(1,19),(2,19),(3,19),(7,19),(8,19),(9,19),(10,19),(3,20),(9,21),(4,22),(5,23),(6,24),(7,25),(1,26),(2,26),(3,26),(7,26),(8,26),(9,26),(10,26),(10,27),(9,30);
/*!40000 ALTER TABLE `diseaseTests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `diseases`
--

DROP TABLE IF EXISTS `diseases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `diseases` (
  `disease_id` int NOT NULL AUTO_INCREMENT,
  `disease_name` varchar(500) NOT NULL,
  `disease_desc` varchar(500) DEFAULT NULL,
  `department_id` int NOT NULL,
  PRIMARY KEY (`disease_id`),
  KEY `department_id` (`department_id`),
  KEY `idx_disease_name` (`disease_name`),
  CONSTRAINT `department_id` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `diseases`
--

LOCK TABLES `diseases` WRITE;
/*!40000 ALTER TABLE `diseases` DISABLE KEYS */;
INSERT INTO `diseases` VALUES (1,'Breast Cancer','Breast cancer is cancer that forms in the cells of the breasts. It can occur in both men and women, but it is much more common in women.',2),(2,'Lung Cancer','Lung cancer is a type of cancer that begins in the lungs. Your lungs are two spongy organs in your chest that take in oxygen when you inhale and release carbon dioxide when you exhale.',7),(3,'Colorectal Cancer','Colorectal cancer is a type of cancer that starts in the colon or rectum. The colon and the rectum are parts of the large intestine, which is the lower part of the body’s digestive system.',4),(4,'Prostate Cancer','Prostate cancer is cancer that occurs in the prostate — a small walnut-shaped gland in men that produces the seminal fluid that nourishes and transports sperm.',5),(5,'Ovarian Cancer','Ovarian cancer is a type of cancer that begins in the ovaries. The ovaries are the female reproductive organs that produce eggs.',6),(6,'Pancreatic Cancer','Pancreatic cancer begins in the tissues of your pancreas — an organ in your abdomen that lies horizontally behind the lower part of your stomach.',7),(7,'Skin Cancer (Melanoma)','Melanoma is a type of skin cancer that develops from the pigment-producing cells known as melanocytes.',8),(8,'Leukemia','Leukemia is a cancer of the blood cells. It starts in the bone marrow, the soft tissue inside most bones.',9),(9,'Cervical Cancer','Cervical cancer is a type of cancer that occurs in the cells of the cervix — the lower part of the uterus that connects to the vagina.',6),(10,'Thyroid Cancer','Thyroid cancer is a type of cancer that starts in the cells of your thyroid — a butterfly-shaped gland located at the base of your neck.',11);
/*!40000 ALTER TABLE `diseases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctors`
--

DROP TABLE IF EXISTS `doctors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctors` (
  `doctor_id` int NOT NULL AUTO_INCREMENT,
  `doctor_name` varchar(500) NOT NULL,
  `doctor_phno` varchar(15) DEFAULT NULL,
  `doctor_office_no` varchar(15) DEFAULT NULL,
  `doctor_office_address` varchar(500) DEFAULT NULL,
  `department_id` int DEFAULT NULL,
  PRIMARY KEY (`doctor_id`),
  KEY `doctors_department_id` (`department_id`),
  CONSTRAINT `doctors_department_id` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctors`
--

LOCK TABLES `doctors` WRITE;
/*!40000 ALTER TABLE `doctors` DISABLE KEYS */;
INSERT INTO `doctors` VALUES (1,'Dr. Smith','123-456-7890','987-654-3210','123 Main St',2),(2,'Dr. Johnson','234-567-8901','876-543-2109','456 Oak St',3),(3,'Dr. Davis','345-678-9012','765-432-1098','789 Pine St',4),(4,'Dr. Wilson','456-789-0123','654-321-0987','321 Elm St',5),(5,'Dr. Miller','567-890-1234','543-210-9876','654 Birch St',6),(6,'Dr. Anderson','678-901-2345','432-109-8765','987 Maple St',7),(7,'Dr. Taylor','789-012-3456','321-098-7654','876 Cedar St',8),(8,'Dr. Moore','890-123-4567','210-987-6543','543 Walnut St',9),(9,'Dr. Jackson','901-234-5678','109-876-5432','234 Spruce St',10),(10,'Dr. Harris','012-345-6789','098-765-4321','567 Pine St',11),(11,'Dr. Garcia','111-222-3333','999-888-7777','789 Oak St',2),(12,'Dr. Rodriguez','222-333-4444','777-666-5555','456 Elm St',2),(13,'Dr. Hernandez','333-444-5555','666-555-4444','123 Maple St',2),(14,'Dr. Diaz','444-555-6666','555-444-3333','890 Pine St',2),(15,'Dr. Lopez','555-666-7777','444-333-2222','678 Cedar St',3),(16,'Dr. Gonzalez','666-777-8888','333-222-1111','901 Walnut St',3),(17,'Dr. Perez','777-888-9999','222-111-0000','345 Spruce St',3),(18,'Dr. Torres','888-999-0000','111-000-9999','678 Birch St',3),(19,'Dr. Ramirez','999-000-1111','000-999-8888','234 Cedar St',4),(20,'Dr. Flores','000-111-2222','999-888-7777','789 Oak St',4),(21,'Dr. Cruz','111-222-3333','888-777-6666','456 Elm St',4),(22,'Dr. Gomez','222-333-4444','777-666-5555','123 Maple St',4),(23,'Dr. Reed','333-444-5555','666-555-4444','890 Pine St',5),(24,'Dr. Campbell','444-555-6666','555-444-3333','678 Cedar St',5),(25,'Dr. Russell','555-666-7777','444-333-2222','901 Walnut St',5),(26,'Dr. Cook','666-777-8888','333-222-1111','345 Spruce St',5),(27,'Dr. Morgan','777-888-9999','222-111-0000','678 Birch St',6),(28,'Dr. Bell','888-999-0000','111-000-9999','234 Cedar St',6),(29,'Dr. Murphy','999-000-1111','000-999-8888','789 Oak St',6),(30,'Dr. Bailey','000-111-2222','999-888-7777','456 Elm St',6),(31,'Dr. Cooper','111-222-3333','888-777-6666','123 Maple St',7),(32,'Dr. Richardson','222-333-4444','777-666-5555','890 Pine St',7),(33,'Dr. Cox','333-444-5555','666-555-4444','678 Cedar St',7),(34,'Dr. Howard','444-555-6666','555-444-3333','901 Walnut St',7),(35,'Dr. Ward','555-666-7777','444-333-2222','345 Spruce St',8),(36,'Dr. Peterson','666-777-8888','333-222-1111','678 Birch St',8),(37,'Dr. Jenkins','777-888-9999','222-111-0000','234 Cedar St',8),(38,'Dr. Perry','888-999-0000','111-000-9999','789 Oak St',8),(39,'Dr. Powell','999-000-1111','000-999-8888','456 Elm St',9),(40,'Dr. Long','000-111-2222','999-888-7777','123 Maple St',9),(41,'Dr. Patterson','111-222-3333','888-777-6666','890 Pine St',9),(42,'Dr. Hughes','222-333-4444','777-666-5555','678 Cedar St',9),(43,'Dr. Flores','333-444-5555','666-555-4444','901 Walnut St',10),(44,'Dr. Washington','444-555-6666','555-444-3333','345 Spruce St',10),(45,'Dr. Butler','555-666-7777','444-333-2222','678 Birch St',10),(46,'Dr. Simmons','666-777-8888','333-222-1111','234 Cedar St',10),(47,'Dr. Foster','777-888-9999','222-111-0000','789 Oak St',11),(48,'Dr. Gonzales','888-999-0000','111-000-9999','456 Elm St',11),(49,'Dr. Bryant','999-000-1111','000-999-8888','123 Maple St',11),(50,'Dr. Alexander','000-111-2222','999-888-7777','890 Pine St',11),(51,'Dr. Sebastian','122-344-5667','233-455-6778','243 Alpine St',8),(53,'Dr. Artemis','122-344-5668','233-455-6779','243 Palm St',6),(55,'Dr. Aurobindo','345-612-2273','233-455-6771','223 Palm St',9),(56,'Dr. Mohanlal','124-234-1111','980-874-3333','200 Maruti Nagar',5);
/*!40000 ALTER TABLE `doctors` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_doctor_format` BEFORE INSERT ON `doctors` FOR EACH ROW BEGIN
    DECLARE error_message VARCHAR(255);

    IF NEW.doctor_phno REGEXP '^[0-9]{3}-[0-9]{3}-[0-9]{4}$' THEN
        SET error_message = NULL;
    ELSE
        SET error_message = 'Invalid phone number format. Please use XXX-XXX-XXXX format.';
    END IF;

    IF NEW.doctor_office_no REGEXP '^[0-9]{3}-[0-9]{3}-[0-9]{4}$' THEN
        SET error_message = NULL;
    ELSE
        SET error_message = 'Invalid office number format. Please use XXX-XXX-XXXX format.';
    END IF;

    IF error_message IS NOT NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_message;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `symptoms`
--

DROP TABLE IF EXISTS `symptoms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `symptoms` (
  `symptom_id` int NOT NULL AUTO_INCREMENT,
  `symptom_name` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`symptom_id`),
  KEY `idx_symptom_name` (`symptom_name`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `symptoms`
--

LOCK TABLES `symptoms` WRITE;
/*!40000 ALTER TABLE `symptoms` DISABLE KEYS */;
INSERT INTO `symptoms` VALUES (17,'Abdominal bloating or swelling'),(12,'Abdominal pain or discomfort'),(19,'Abdominal pain that may radiate to the back'),(29,'Abnormal vaginal bleeding (between periods, after sex, or after menopause)'),(24,'Bleeding or oozing from a mole'),(11,'Blood in the stool'),(14,'Blood in the urine or semen'),(10,'Changes in bowel habits (diarrhea, constipation, or narrowing of the stool)'),(22,'Changes in the size, color, or shape of moles'),(2,'Changes in the size, shape, or appearance of the breast'),(6,'Chest pain or discomfort'),(9,'Coughing up blood'),(34,'Difficulty swallowing'),(13,'Difficulty urinating or changes in urinary habits'),(27,'Easy bruising or bleeding'),(28,'Enlarged lymph nodes or spleen'),(15,'Erectile dysfunction'),(25,'Fatigue and weakness'),(18,'Feeling full quickly while eating'),(26,'Frequent infections'),(33,'Hoarseness or voice changes'),(23,'Itching or tenderness in a mole'),(20,'Jaundice (yellowing of the skin and eyes)'),(21,'Loss of appetite'),(1,'Lump in the breast or underarm'),(32,'Lump or swelling in the neck (thyroid nodule)'),(4,'Nipple discharge (other than breast milk)'),(30,'Pain during sex'),(35,'Pain in the neck or throat'),(16,'Pelvic pain or discomfort'),(5,'Persistent cough or changes in a chronic cough'),(7,'Shortness of breath'),(3,'Unexplained pain in the breast or nipple'),(8,'Unexplained weight loss'),(31,'Vaginal discharge with an unpleasant odor');
/*!40000 ALTER TABLE `symptoms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tests`
--

DROP TABLE IF EXISTS `tests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tests` (
  `test_name` varchar(500) DEFAULT NULL,
  `test_id` int NOT NULL AUTO_INCREMENT,
  `test_desc` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`test_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tests`
--

LOCK TABLES `tests` WRITE;
/*!40000 ALTER TABLE `tests` DISABLE KEYS */;
INSERT INTO `tests` VALUES ('Mammogram',1,'A mammogram is a type of X-ray used to screen for and diagnose breast cancer. It produces images of the breast tissue that can reveal abnormalities such as tumors or cysts.'),('Chest X-ray',2,'A chest X-ray is a common imaging test used to diagnose lung cancer. It produces images of the chest area to detect abnormalities in the lungs, such as tumors, nodules, or fluid buildup.'),('Colonoscopy',3,'A colonoscopy is a procedure used to examine the colon and rectum for signs of colorectal cancer. It involves inserting a long, flexible tube with a camera into the rectum to view the colon and detect polyps, tumors, or other abnormalities.'),('PSA Blood Test',4,'The PSA blood test measures the level of prostate-specific antigen (PSA) in the blood. It is used to screen for prostate cancer and monitor the effectiveness of treatment in patients diagnosed with prostate cancer.'),('Pelvic Ultrasound',5,'A pelvic ultrasound is an imaging test used to diagnose ovarian cancer. It uses sound waves to create images of the pelvic organs, including the ovaries, uterus, and fallopian tubes, to detect abnormalities such as tumors or cysts.'),('CT Scan',6,'A CT scan, or computed tomography scan, is a diagnostic imaging test used to diagnose pancreatic cancer. It provides detailed cross-sectional images of the abdomen and pelvis to detect tumors, evaluate the extent of the disease, and guide treatment planning.'),('Skin Biopsy',7,'A skin biopsy is a procedure used to diagnose skin cancer. It involves removing a small sample of skin tissue for examination under a microscope to detect cancer cells and determine the type and stage of skin cancer.'),('Complete Blood Count (CBC)',8,'A complete blood count (CBC) is a blood test used to diagnose leukemia. It measures the number and types of blood cells in the body, including red blood cells, white blood cells, and platelets, to detect abnormalities such as leukemia cells.'),('Pap Smear',9,'A Pap smear, also called a Pap test, is a screening test used to detect cervical cancer. It involves collecting cells from the cervix to examine for abnormalities or precancerous changes that could indicate the presence of cervical cancer.'),('Thyroid Ultrasound',10,'A thyroid ultrasound is an imaging test used to diagnose thyroid cancer. It uses sound waves to create images of the thyroid gland to detect nodules, tumors, or other abnormalities that may indicate the presence of thyroid cancer.'),('MRI Scan',11,'Magnetic Resonance Imaging test for detailed cancer detection.'),('PET Scan',12,'Positron Emission Tomography test for cancer staging and monitoring.'),('Genetic Testing',13,'DNA analysis to identify genetic predispositions to cancer.'),('Biopsy',14,'Tissue sample examination for definitive cancer diagnosis.'),('Endoscopy',15,'Visual examination of internal organs for cancer detection.'),('Bone Marrow Aspiration',16,'Procedure to extract bone marrow for leukemia diagnosis.'),('Blood Chemistry Panel',17,'Blood test to assess overall health and detect abnormalities.'),('Immunohistochemistry',18,'Lab test to analyze protein expression in cancer cells.'),('Urine Cytology',19,'Urine test to detect abnormal cells indicative of cancer.'),('Colonography',20,'Virtual colonoscopy for colorectal cancer screening.'),('Cervical Biopsy',21,'Tissue sample collection from the cervix for cervical cancer diagnosis.'),('Prostate Biopsy',22,'Tissue sample collection from the prostate gland for prostate cancer diagnosis.'),('CA-125 Blood Test',23,'Biomarker test for ovarian cancer detection and monitoring.'),('Pancreatic Enzyme Test',24,'Blood test to measure pancreatic enzyme levels for pancreatic cancer.'),('Skin Patch Test',25,'Allergy test to assess skin reactions and identify potential triggers.'),('Lymph Node Biopsy',26,'Tissue sample collection from lymph nodes for cancer staging.'),('Thyroid Function Test',27,'Blood test to assess thyroid hormone levels for thyroid cancer screening.'),('Bone Density Test',28,'Imaging test to assess bone strength and detect abnormalities.'),('Lung Function Test',29,'Breathing test to evaluate lung function and detect respiratory issues.'),('Papillomavirus Test',30,'HPV DNA test for cervical cancer screening.');
/*!40000 ALTER TABLE `tests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `DiseaseDetails`
--

/*!50001 DROP VIEW IF EXISTS `DiseaseDetails`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `DiseaseDetails` AS select `d`.`disease_id` AS `disease_id`,`d`.`disease_name` AS `disease_name`,`d`.`disease_desc` AS `disease_desc`,`dp`.`department_name` AS `department_name`,`s`.`symptom_name` AS `symptom_name`,`t`.`test_name` AS `test_name`,`dr`.`doctor_name` AS `doctor_name` from ((((((`diseases` `d` join `diseaseSymptoms` `ds` on((`ds`.`disease_id` = `d`.`disease_id`))) left join `symptoms` `s` on((`ds`.`symptom_id` = `s`.`symptom_id`))) left join `diseaseTests` `dt` on((`d`.`disease_id` = `dt`.`disease_id`))) left join `tests` `t` on((`dt`.`test_id` = `t`.`test_id`))) left join `doctors` `dr` on((`d`.`department_id` = `dr`.`department_id`))) left join `departments` `dp` on((`d`.`department_id` = `dp`.`department_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-02-18 21:56:35
