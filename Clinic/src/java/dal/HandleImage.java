package dal;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

public class HandleImage {

    public static boolean deleteImage(String path) {
        boolean flag = false;
        try {
            File file = new File(path);
            flag = file.delete();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Error in dal.HandleImage.deleteImage()");
        }
        return flag;
    }

    public static boolean saveImage(InputStream is, String path) {
        boolean flag = false;
        try {
            byte inputFile[] = new byte[is.available()];
            is.read(inputFile);
            FileOutputStream fos = new FileOutputStream(path);
            fos.write(inputFile);
            fos.flush();
            fos.close();

            flag = true;
        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("Error in dal.HandleImage.saveImage()");
        }

        return flag;
    }
}
