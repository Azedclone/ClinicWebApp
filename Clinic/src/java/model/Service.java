package model;

public class Service {

    private int serviceID;
    private String serviceName;
    private double price;
    private int status;

    public Service() {
    }

    public Service(int serviceID, String serviceName, double price, int status) {
        this.serviceID = serviceID;
        this.serviceName = serviceName;
        this.price = price;
        this.status = status;
    }

    public int getServiceID() {
        return serviceID;
    }

    public void setServiceID(int serviceID) {
        this.serviceID = serviceID;
    }

    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

}
