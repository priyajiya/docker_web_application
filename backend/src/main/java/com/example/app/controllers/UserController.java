package com.example.app.controllers;

import org.springframework.web.bind.annotation.*;
import java.util.*;

@RestController
@RequestMapping("/api/users")
public class UserController {

    private final List<Map<String, String>> users = new ArrayList<>();

    @PostMapping("/register")
    public String registerUser(@RequestBody Map<String, String> user) {
        users.add(user);
        return "User registered successfully!";
    }

    @GetMapping
    public List<Map<String, String>> getAllUsers() {
        return users;
    }
}
