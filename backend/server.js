const express = require("express");
const mongoose = require("mongoose");
const bodyParser = require("body-parser");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

const app = express();
const port = 3000;

// Connect to MongoDB
mongoose
  .connect("mongodb://localhost:27017/giverFlutterLogin", {})
  .then(() => {
    console.log("MongoDB connected successfully");
  })
  .catch((error) => {
    console.error("Error connecting to MongoDB:", error);
  });

// Define user schema
const userSchema = new mongoose.Schema({
  username: String,
  password: String,
});

const User = mongoose.model("User", userSchema);

app.use(bodyParser.json());

// User login endpoint

app.post("/register", async (req, res) => {
  const { username, password } = req.body;
  const existingUser = await User.findOne({ username });

  if (existingUser) {
    return res.status(400).json({ message: "Username already exists" });
  }

  const hashedPassword = await bcrypt.hash(password, 10);
  const newUser = new User({ username, password: hashedPassword });

  try {
    await newUser.save();
    res.status(201).json({ message: "User registered successfully" });
  } catch (error) {
    res.status(500).json({ message: "Failed to register user" });
  }
});

app.post("/login", async (req, res) => {
  const { username, password } = req.body;
  const user = await User.findOne({ username });

  if (!user) {
    return res.status(404).json({ message: "User not found" });
  }

  const isValidPassword = bcrypt.compare(password, user.password);
  if (!isValidPassword) {
    return res.status(401).json({ message: "Invalid password" });
  }

  const token = jwt.sign({ username }, "secret_key");
  res.json({ token });
});

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
