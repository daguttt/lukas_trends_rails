# LukasTrends

Discover the forecast of the top currencies and cryptos as well as their history

## Project setup

### 1. Environment variables

Create a `.env` file and populate it based on the content of [`.env.erb`](.env.erb) template file.
Environment variables include:

  1. Database Credentials.

> [!NOTE]
> Keep the value of the `DATABASE_NAME` as is. It's not used in development but required to run the project

### 2. Install dependencies

```bash
bundle i
```

### 3. Database setup

1. Create database `rails db:migrate`.
2. Run migrations `rails db:migrate`.