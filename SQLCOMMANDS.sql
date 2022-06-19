
create table user(
    id INT(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    fullName varchar(100) NOT NULL,
    email varchar(255) NOT NULL UNIQUE,
    pass varchar(255) NOT NULL,
    verified Boolean NOT NULL DEFAULT false
)

create table courses(
    id int(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    userId int(11) UNSIGNED NOT NULL,
    courseName varchar(255) NOT NULL,
    imageUrl varchar(255) NOT NULL,
    courseDescription varchar(255) NOT NULL,
    createTime DATETIME NOT NULL,
    startTime DATETIME NOT NULL,
    endTime DATETIME NOT NULL,
    courseFormat varchar(20) NOT NULL,
    FOREIGN KEY (userId) REFERENCES user(id) 
)

create table poolCategory(
    id int(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    courseId int(11) UNSIGNED NOT NULL,
    userId int(11) UNSIGNED NOT NULL,
    categoryName varchar(255) NOT NULL,
    FOREIGN KEY (courseId) REFERENCES courses(id),
    FOREIGN KEY (userId) REFERENCES user(id) 
)

create table poolQuestions(
    id int(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    courseId int(11) UNSIGNED NOT NULL,
    courseName varchar(255) NOT NULL,
    question varchar (255) NOT NULL,
    correctOption varchar (255) NOT NULL,
    questionType varchar(255) NOT NULL,
    poolCategoryId int(11) UNSIGNED NOT NULL,
    userId int(11) UNSIGNED NOT NULL,
    FOREIGN KEY (courseId) REFERENCES courses(id),
    FOREIGN KEY (userId) REFERENCES user(id),
    FOREIGN KEY (poolCategoryId) REFERENCES poolCategory(id) 
)

create table questionOptions(
    id int(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    questionId int(11) UNSIGNED NOT NULL,
    options varchar(255) NOT NULL,
    FOREIGN KEY (questionId) REFERENCES poolQuestions(id)
)


-- select * from poolQuestions where userId=?

-- SELECT 
--     *,questionOptions.questionId,questionOptions.options
-- FROM 
--     poolQuestions
-- CROSS JOIN 
--     questionOptions 
-- ON
--     poolQuestions.id=questionOptions.questionId

create table enrolled(
    id int(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    courseId int(11) UNSIGNED NOT NULL,
    userId int(11) UNSIGNED NOT NULL,
    joinedTime DATETIME NOT NULL,
    FOREIGN KEY (courseId) REFERENCES courses(id),
    FOREIGN KEY (userId) REFERENCES user(id),
)

create table courseContent(
    id int(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    courseId int(11) UNSIGNED NOT NULL,
    fileUrl varchar(255) NOT NULL,
    fileName varchar(255) NOT NULL,
    fileType varchar(255) NOT NULL,
    createdTime DATETIME NOT NULL,
    FOREIGN KEY (courseId) REFERENCES courses(id),
)


create table assignment(
    id int(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    assignmentTitle varchar(255) NOT NULL,
    courseId int(11) UNSIGNED NOT NULL,
    fileUrl varchar(255) NOT NULL,
    fileName varchar(255) NOT NULL,
    createdTime DATETIME NOT NULL,
    startTime DATETIME NOT NULL,
    endTime DATETIME NOT NULL,
    -- userId int(11) UNSIGNED NOT NULL,
    FOREIGN KEY (courseId) REFERENCES courses(id),
    FOREIGN KEY (userId) REFERENCES user(id),
)

create table uploadAssignment(
    id int(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    courseId int(11) UNSIGNED NOT NULL,
    userId int(11) UNSIGNED NOT NULL,
    fileUrl varchar(255) NOT NULL,
    uploadTime DATETIME NOT NULL,
    FOREIGN KEY (courseId) REFERENCES courses(id),
    FOREIGN KEY (userId) REFERENCES user(id),
)

create table assignmentResult(
    id int(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    courseId int(11) UNSIGNED NOT NULL,
    userId int(11) UNSIGNED NOT NULL,
    uaId int(11) UNSIGNED NOT NULL,
    marks int(10) NOT NULL,
    FOREIGN KEY (courseId) REFERENCES courses(id),
    FOREIGN KEY (userId) REFERENCES user(id),
)

create table quiz(
    id int(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    quizTitle varchar(255) NOT NULL,
    courseId int(11) UNSIGNED NOT NULL,
    createdTime DATETIME NOT NULL,
    startTime DATETIME NOT NULL,
    endTime DATETIME NOT NULL,
    -- userId int(11) UNSIGNED NOT NULL,
    FOREIGN KEY (courseId) REFERENCES courses(id),
    FOREIGN KEY (userId) REFERENCES user(id),
)

create table quizQuestions(
    id int(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    quizId int(11) UNSIGNED,
    questionId int(11) UNSIGNED,
    FOREIGN KEY (quizId) REFERENCES quiz(id),
    FOREIGN KEY (questionId) REFERENCES poolQuestions(id),
)

create table attemptedQuiz(
    id int(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    quizId int(11) UNSIGNED,
    questionId int(11) UNSIGNED,
    userId int(11) UNSIGNED NOT NULL,
    userAnswer varchar(255) NOT NULL,
    FOREIGN KEY (quizId) REFERENCES quiz(id),
    FOREIGN KEY (questionId) REFERENCES poolQuestions(id),
    FOREIGN KEY (userId) REFERENCES user(id),
);

create table quizResult(
    id int(11) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    quizId int(11) UNSIGNED,
    userId int(11) UNSIGNED NOT NULL,
    questionId int(11) UNSIGNED,
    marks int(10) NOT NULL,
    FOREIGN KEY (quizId) REFERENCES quiz(id),
    FOREIGN KEY (questionId) REFERENCES poolQuestions(id),
    FOREIGN KEY (userId) REFERENCES user(id),
)