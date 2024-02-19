package cam_System;
import java.awt.Color;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.*;

public class Hodloggedin {
    JFrame frame;
    JComboBox<String> chooseComboBox;
    JComboBox<String> chooseComboBox2;
    JButton viewButton;
    JButton insertButton;

    public Hodloggedin() {
        createForm();
        setLocationAndSize();
        addComponents();
        setupActionListeners();
    }

    private void createForm() {
        frame = new JFrame();
        frame.setTitle("HOD Logged In");
        frame.setBounds(450, 100, 550, 200);
        frame.getContentPane().setLayout(null);
        frame.setVisible(true);
        frame.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        frame.setResizable(false);
        frame.getContentPane().setBackground(Color.white);
    }

    private void setLocationAndSize() {
        JLabel chooseLabel = new JLabel("Choose view:");
        chooseLabel.setBounds(50, 50, 100, 30);
        frame.add(chooseLabel);
        
        JLabel chooseLabel2 = new JLabel("Choose insert:");
        chooseLabel2.setBounds(50, 90, 100, 30);
        frame.add(chooseLabel2);

        chooseComboBox = new JComboBox<>();
        chooseComboBox.addItem("View Teachers");
        chooseComboBox.addItem("View Classrooms");
        chooseComboBox.addItem("View Class Representatives");
        chooseComboBox.addItem("View Coordinators");
        chooseComboBox.addItem("View Courses");
        chooseComboBox.addItem("View Booking Records");
        chooseComboBox.setBounds(150, 50, 200, 30);
        frame.add(chooseComboBox);
        viewButton = new JButton("View");
        viewButton.setBounds(370, 50, 100, 30);
        frame.add(viewButton);
        
        chooseComboBox2 = new JComboBox<>();
        chooseComboBox2.addItem("Insert a Teacher");
        chooseComboBox2.addItem("Insert a Coordinator");
        chooseComboBox2.addItem("Insert a Course");
        chooseComboBox2.setBounds(150, 90, 200, 30);
        frame.add(chooseComboBox2);
        insertButton = new JButton("insert");
        insertButton.setBounds(370, 90, 100, 30);
        
        frame.add(insertButton);
    }

    private void addComponents() {
    }

    private void setupActionListeners() {
        viewButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String selectedItem = (String) chooseComboBox.getSelectedItem();
                switch (selectedItem) {
                    case "View Teachers":
                        viewTeachers();
                        break;
                    case "View Classrooms":
                        viewClassrooms();
                        break;
                    case "View Class Representatives":
                        viewClassRepresentatives();
                        break;
                    case "View Coordinators":
                        viewCoordinators();
                        break;
                    case "View Courses":
                        viewCourses();
                        break;
                    case "View Booking Records":
                        viewBookingRecords();
                        break;
                    default:
                        JOptionPane.showMessageDialog(frame, "Functionality not implemented yet!", "Info", JOptionPane.INFORMATION_MESSAGE);
                }
            }
        });
        
        insertButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String selectedItem = (String) chooseComboBox2.getSelectedItem();
                switch (selectedItem) {
                    case "Insert a Teacher":
                        new insertTeachers();
                        break;
                    case "Insert a Coordinator":
                        new insertcoordinator();
                        break;
                    case "Insert a Course":
                        new insertcourse();
                        break;
                    default:
                        JOptionPane.showMessageDialog(frame, "Functionality not implemented yet!!", "Info", JOptionPane.INFORMATION_MESSAGE);
                }
            }
        });
    }

    private void viewTeachers() {
        // Code to view teachers from database and display in a table-like format
        String query = "SELECT * FROM teachers";
        displayResultSet(query, "Teachers");
    }

    private void viewClassrooms() {
        // Code to view classrooms from database and display in a table-like format
        String query = "SELECT * FROM classrooms";
        displayResultSet(query, "Classrooms");
    }

    private void viewClassRepresentatives() {
        // Code to view class representatives from database and display in a table-like format
        String query = "SELECT * FROM classrepresentatives";
        displayResultSet(query, "Class Representatives");
    }

    private void viewCoordinators() {
        // Code to view coordinators from database and display in a table-like format
        String query = "SELECT * FROM coordinators";
        displayResultSet(query, "Coordinators");
    }

    private void viewCourses() {
        // Code to view courses from database and display in a table-like format
        String query = "SELECT * FROM courses";
        displayResultSet(query, "Courses");
    }

    private void viewBookingRecords() {
        // Code to view booking records from database and display in a table-like format
        String query = "SELECT * FROM bookingrecords";
        displayResultSet(query, "Booking Records");
    }

    private void displayResultSet(String query, String title) {
        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Ngoma_Osborne_222004457", "ngoma_osborne", "222004457");
             PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            // Create JTable and display ResultSet
            JTable table = new JTable(buildTableModel(rs));
            JOptionPane.showMessageDialog(frame, new JScrollPane(table), title, JOptionPane.PLAIN_MESSAGE);
        } catch (SQLException e) {
            e.printStackTrace();
            JOptionPane.showMessageDialog(frame, "An error occurred while fetching data from the database.", "Error", JOptionPane.ERROR_MESSAGE);
        }
    }

    private static javax.swing.table.DefaultTableModel buildTableModel(ResultSet rs) throws SQLException {
        // Create meta-data object
        java.sql.ResultSetMetaData metaData = rs.getMetaData();

        // Get column count
        int columnCount = metaData.getColumnCount();

        // Create column names array
        String[] columnNames = new String[columnCount];

        // Get column names
        for (int column = 1; column <= columnCount; column++) {
            columnNames[column - 1] = metaData.getColumnName(column);
        }

        // Create data array
        Object[][] data = new Object[100][columnCount]; // Assuming a maximum of 100 rows

        // Populate data array
        int rowCount = 0;
        while (rs.next()) {
            for (int column = 1; column <= columnCount; column++) {
                data[rowCount][column - 1] = rs.getObject(column);
            }
            rowCount++;
        }

        // Create DefaultTableModel with data and column names
        return new javax.swing.table.DefaultTableModel(data, columnNames);
    }

    public static void main(String[] args) {
        new Hodloggedin();
    }
}
