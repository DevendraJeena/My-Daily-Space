# My Daily Space

My Daily Space is a **web application** designed to help you stay organized and productive.
It lets you **keep track of your daily notes, goals, expenses, to-dos, files, and reminders**, all in a single place.
The application is implemented using **JSP, Servlets, JDBC, MySQL, and MVC architecture**.

---

##  Features

 **User Authentication**

* User registration and login with password authentication.

 **Notes Module**

* Add, view, and delete notes.

 **Goals Module**

* Set goals and track their progress.

 **To-Do List**

* Add, update, and delete daily tasks.

 **Reminders**

* Set short reminders for future tasks.

 **File Upload**

* Upload files and documents for future reference.

 **Expense Manager**

* Keep a record of expenses and view total spending.

---

## 🛠 Tech Stack

* **Front-end:** JSP, HTML, CSS, Bootstrap
* **Back-end:** Servlets, JDBC, MVC architecture
* **Database:** MySQL
* **Server:** Apache Tomcat
* **IDE:** Eclipse or IntelliJ
* **Web Container:** Apache Tomcat (v9+)

---

## Project Structure (MVC)

```
MyDailySpace/
 ├─ src/
    ├─ controller/ (Servlets) 
    ├─ model/ (JavaBeans, POJOs) 
    ├─ dao/ (Database Access) 
 ├─ WebContent/
    ├─ WEB-INF/
       ├─ view/ (JSP files) 
    ├─ css/
    ├─ images/
 ├─ pom.xml (if using Maven) 
```

---

##  Database Schema (MySQL)

* **Users:** (id, username, email, password, …)
* **Notes:** (note\_id, user\_id, title, content)
* **Goals:** (goal\_id, user\_id, description, progress)
* **To-Do:** (task\_id, user\_id, task, is\_done)
* **Reminders:** (reminder\_id, user\_id, message, datetime)
* **Files:** (file\_id, user\_id, file\_name, path)
* **Expenses:** (expense\_id, user\_id, amount, description, date)

---

##  Installation and Run

1️⃣ **Clone this repository:**

```bash
git clone https://github.com/yourUsername/my-daily-space.git
```

2️⃣ **Import into IDE (Eclipse or IntelliJ)** — File > Import > Existing Project.

3️⃣ **Create MySQL Database:**

* Open MySQL and execute `schema.sql` (provided in the directory) or manually create the required tables.

4️⃣ **Change Database credentials:**

* Update `db.properties` or `DBUtil.java` with your MySQL credentials.

5️⃣ **Deploy on Tomcat:**

* Right-click on project > Run on Tomcat.

6️⃣ Access the application at:

```
http://localhost:8080/my-daily-space/
```

---

##  Acknowledgements

* **JSP, Servlets, JDBC, MySQL, Tomcat**
* **MVC architecture to separate responsibilities**
* **Eclipse / IntelliJ IDE**

---

## 📝 Notes

* The application performs **CRUD operations** (Create, Retrieve, Update, Delete) on all modules.
* User sessions are maintained upon login and destroyed upon logout.

---

