package com.model;

public class ContactModel {

    private String Id;
    private String Name;
    private String MobilePhone; 
    private String Email;
    
    
    public ContactModel() {
        Id=null;
        Name=null;
        MobilePhone= null; 
        Email = null;
    } 

    public ContactModel(String id, String name, String mobilePhone, String email) {
    	Id=id;
        Name=name;
        MobilePhone= mobilePhone; 
        Email = email;
    }

    public String getId() {
        return Id;
    }
    
    public void setId(String id) {
        Id = id;
    }
    
    public String getName() {
        return Name;
    }
    
    public void setName(String name) {
        Name = name;
    }
    
    public String getMobilePhone() {
        return MobilePhone;
    }
    
    public void setMobilePhone(String mobilePhone) {
    	MobilePhone = mobilePhone;
    }
    
    public String getEmail() {
        return Email;
    }
    
    public void setEmail(String email) {
    	Email = email;
    }
}
