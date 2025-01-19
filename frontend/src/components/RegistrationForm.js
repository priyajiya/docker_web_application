import React, { useState } from 'react';

function RegistrationForm() {
    const [formData, setFormData] = useState({
        name: '',
        age: '',
        sex: '',
        course: '',
        department: ''
    });

    const handleChange = (e) => {
        setFormData({ ...formData, [e.target.name]: e.target.value });
    };

    const handleSubmit = (e) => {
        e.preventDefault();
        fetch('/api/users/register', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(formData)
        }).then(response => response.text()).then(data => alert(data));
    };

    return (
        <form onSubmit={handleSubmit}>
            <input type="text" name="name" placeholder="Name" onChange={handleChange} required />
            <input type="number" name="age" placeholder="Age" onChange={handleChange} required />
            <select name="sex" onChange={handleChange} required>
                <option value="">Select Gender</option>
                <option value="Male">Male</option>
                <option value="Female">Female</option>
                <option value="Other">Other</option>
            </select>
            <select name="course" onChange={handleChange} required>
                <option value="">Select Course</option>
                <option value="DevOps">DevOps</option>
                <option value="CloudOps">CloudOps</option>
                <option value="AI">AI</option>
                <option value="Machine Learning">Machine Learning</option>
            </select>
            <input type="text" name="department" placeholder="Department" onChange={handleChange} required />
            <button type="submit">Submit</button>
            <button type="reset">Cancel</button>
        </form>
    );
}

export default RegistrationForm;

