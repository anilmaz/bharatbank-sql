# 🇮🇳 BharatBank SQL Server Container (dbhitman/bharatbank-sql)

A modular, production-grade SQL Server 2025 CTP container tailored for the Indian Banking & Finance vertical. Built for learners, educators, and architects who want to master SQL Server in a modern, containerized workflow.

---

## 🚀 Why Learn SQL Server in 2025?

SQL Server remains one of the most widely adopted relational database platforms in enterprise environments — especially across BFSI, healthcare, and government sectors in India.

- 🔐 Trusted by banks, insurers, and regulators (RBI, SEBI)
- 🧠 Strong support for stored procedures, triggers, and analytics
- 🛡️ Built-in security, compliance, and audit features
- 🧩 Ideal for modeling real-world financial systems

---

## 🐳 Why Use Containers?

Containers make database learning and deployment:

- ⚡ Fast: No installation headaches — just pull and run
- 🧼 Clean: Isolated environments for each vertical or use case
- 🔁 Reproducible: Share exact setups with teams or students
- 📦 Portable: Push to Docker Hub, run anywhere

This project uses Docker volumes to persist data and supports remote access via SSMS.

---

## 🏦 What's Inside the BharatBank Schema?

| Module         | Tables Included                                                                 |
|----------------|----------------------------------------------------------------------------------|
| Core Banking   | `Customers`, `Accounts`, `Transactions`                                         |
| Lending        | `Loans`, `EMI_Schedule`, `LoanTypes`                                            |
| Infrastructure | `Branches`, `Staff`, `Roles`                                                    |
| Compliance     | `KYC_Documents`, `AuditLogs`                                                    |
| Payments       | UPI, NEFT, IMPS-ready transaction modes                                         |

Sample data includes Aadhaar, PAN, IFSC, EMI schedules, and UPI references — making it ideal for RBI sandbox simulations or fintech prototyping.

---

## 🧪 How to Use

### 1. Pull the image

docker pull dbhitman/bharatbank-sql:v1

2. Create a volume for persistent data

   docker volume create bharatbank-data

3. Run the container

docker run -d -p 1433:1433 \
  --name sql1 \
  -e "ACCEPT_EULA=Y" \
  -e "SA_PASSWORD=YourStrong!Passw0rd" \
  -v bharatbank-data:/var/opt/mssql \
  dbhitman/bharatbank-sql:v1

  4. Connect via SSMS
- Server: localhost,1433
- Login: SA
- Password: YourStrong!Passw0rd


🧠 Who Is This For?
- 🧑‍🎓 Students learning SQL Server fundamentals
- 🧑‍💻 Developers prototyping BFSI apps
- 🏛️ Educators teaching database design
- 🏗️ Architects modeling real-world financial systems

📚 Learn More
- SQL Server Documentation - https://learn.microsoft.com/en-us/sql/sql-server/?view=sql-server-ver17
- Docker for Windows - https://docs.docker.com/desktop/windows/
  

🛠️ Contribute
Want to add Healthcare, Retail, or Education verticals? Fork this repo and submit a pull request. Let’s build India-first database containers together.

🏁 License
MIT — use it, remix it, teach with it.

---


