package com.fastcampus.ch4.domain;

import java.util.Date;
import java.util.Objects;

public class User {
    private String id;
    private String pwd;
    private String name;
    private String email;
    private String Country;

    public User(){}
    public User(String id, String pwd, String name, String email, String Country) {
        this.id = id;
        this.pwd = pwd;
        this.name = name;
        this.email = email;
        this.Country = Country;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        User user = (User) o;
        return id.equals(user.id) && Objects.equals(pwd, user.pwd) && Objects.equals(name, user.name) && Objects.equals(email, user.email)&& Objects.equals(Country, user.Country);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, pwd, name, email, Country);
    }

    @Override
    public String toString() {
        return "User{" +
                "id='" + id + '\'' +
                ", pwd='" + pwd + '\'' +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", Country='" + Country + '\'' +
                '}';
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    public String getCountry() {
        return Country;
    }

    public void setCountry(String Country) {
        this.Country = Country;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }


}