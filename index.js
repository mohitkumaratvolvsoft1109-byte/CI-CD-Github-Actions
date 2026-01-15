import express from "express";
const app = express();
const PORT = process.env.PORT || 3000;
const message = process.env.NODE_ENV || "development";

app.get("/", (req, res) => {
  res.send(`Hello, Docker! Environment: ${message}`);
});

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});
