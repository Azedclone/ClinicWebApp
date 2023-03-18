package model;

public class Medicine {

    private int medicineID;
    private String medicineName;
    private String brand;
    private String description;

    public Medicine() {
    }

    public Medicine(int medicineID, String medicineName, String brand, String description) {
        this.medicineID = medicineID;
        this.medicineName = medicineName;
        this.brand = brand;
        this.description = description;
    }

    public int getMedicineID() {
        return medicineID;
    }

    public void setMedicineID(int medicineID) {
        this.medicineID = medicineID;
    }

    public String getMedicineName() {
        return medicineName;
    }

    public void setMedicineName(String medicineName) {
        this.medicineName = medicineName;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

}
