package com.sybus.web.controller.jsonview;

public class Views {
    public static class Public {};
    public static class AddData extends Public{};
    public static class UpdateData extends AddData {};
    public static class DeleteData {};
    public static class DisplayData extends Public{};
    //public static class AjaxPost extends Public{};
    
    //for route stop distance data.
    public static class Single extends Public{};
    public static class Object extends Single{};
    public static class ObjectCollection extends Object{};
    public static class  AllCollection extends ObjectCollection{};
    
    //this is for vehicle
    public static class Location extends Public{};
    
    //for tracking
    public static class Tracking extends DisplayData{};
    
    
}