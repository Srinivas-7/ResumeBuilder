-- ---------------------------------------------------
-- Database: resume_builder_ai
-- ---------------------------------------------------
CREATE DATABASE IF NOT EXISTS resume_builder_ai;
USE resume_builder_ai;

-- ---------------------------------------------------
-- Table: users
-- Stores registered users
-- ---------------------------------------------------
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ---------------------------------------------------
-- Table: resumes
-- Each user can create multiple resumes
-- ---------------------------------------------------
CREATE TABLE IF NOT EXISTS resumes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    contact VARCHAR(100),
    address VARCHAR(255),
    summary TEXT,
    ai_summary TEXT, -- AI enhanced version
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- ---------------------------------------------------
-- Table: education
-- Multiple education entries per resume
-- ---------------------------------------------------
CREATE TABLE IF NOT EXISTS education (
    id INT AUTO_INCREMENT PRIMARY KEY,
    resume_id INT NOT NULL,
    degree VARCHAR(100) NOT NULL,
    institution VARCHAR(150) NOT NULL,
    start_year YEAR,
    end_year YEAR,
    FOREIGN KEY (resume_id) REFERENCES resumes(id) ON DELETE CASCADE
);

-- ---------------------------------------------------
-- Table: experience
-- Multiple work experiences per resume
-- ---------------------------------------------------
CREATE TABLE IF NOT EXISTS experience (
    id INT AUTO_INCREMENT PRIMARY KEY,
    resume_id INT NOT NULL,
    job_title VARCHAR(100) NOT NULL,
    company VARCHAR(150) NOT NULL,
    start_date DATE,
    end_date DATE,
    description TEXT,
    ai_description TEXT, -- AI enhanced version
    FOREIGN KEY (resume_id) REFERENCES resumes(id) ON DELETE CASCADE
);

-- ---------------------------------------------------
-- Table: skills
-- Stores user-entered and AI-suggested skills
-- ---------------------------------------------------
CREATE TABLE IF NOT EXISTS skills (
    id INT AUTO_INCREMENT PRIMARY KEY,
    resume_id INT NOT NULL,
    skill_name VARCHAR(100) NOT NULL,
    is_ai_suggested BOOLEAN DEFAULT FALSE, -- Marks AI-added skills
    FOREIGN KEY (resume_id) REFERENCES resumes(id) ON DELETE CASCADE
);

-- ---------------------------------------------------
-- Table: ai_recommendations
-- General AI suggestions for improvement
-- ---------------------------------------------------
CREATE TABLE IF NOT EXISTS ai_recommendations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    resume_id INT NOT NULL,
    recommendation TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (resume_id) REFERENCES resumes(id) ON DELETE CASCADE
);
