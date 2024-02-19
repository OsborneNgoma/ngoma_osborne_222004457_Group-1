package cam_System;
import java.awt.Color;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.*;

public class coordinatorloggedin implements ActionListener {
    JFrame frame;
    JLabel updateLabel, representativeLabel, dataLabel, classNameLabel, classroomLabel;
    JComboBox<String> representativeDropdown, dataDropdown;
    JButton updateButton, registerClassButton, registerClassroomButton;
    String url = "jdbc:mysql://localhost:3306/Ngoma_Osborne_222004457";
    String UserN = "ngoma_osborne";
    String PassD = "222004457";

    public coordinatorloggedin() {
        frame = new JFrame();
        frame.setTitle("Coordinator Logged In");
        frame.setBounds(550, 130, 500, 300);
        frame.getContentPane().setLayout(null);
        frame.getContentPane().setBackground(Color.white);
        frame.setVisible(true);
        frame.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        frame.setResizable(false);

        createForm();
        setLocationAndSize();
        addComponents();
        setupActionListeners();
        populateRepresentativeDropdown();
        populateDataDropdown();
    }

    private void createForm() {
        updateLabel = new JLabel("Update:");
        representativeLabel = new JLabel("Representative:");
        dataLabel = new JLabel("Data:");
        classNameLabel = new JLabel("Class Name:");
        classroomLabel = new JLabel("Classroom Details:");

        representativeDropdown = new JComboBox<>();
        dataDropdown = new JComboBox<>();

        updateButton = new JButton("Update");
        registerClassButton = new JButton("Register Class");
        registerClassroomButton = new JButton("Register Classroom");
    }

    private void setLocationAndSize() {
        updateLabel.setBounds(20, 20, 100, 30);
        representativeLabel.setBounds(20, 60, 100, 30);
        dataLabel.setBounds(20, 100, 100, 30);

        representativeDropdown.setBounds(120, 60, 200, 30);
        dataDropdown.setBounds(120, 100, 200, 30);

        updateButton.setBounds(180, 140, 100, 30);
        registerClassButton.setBounds(120, 200, 150, 30);
        registerClassroomButton.setBounds(280, 200, 170, 30);
    }

    private void addComponents() {
        frame.add(updateLabel);
        frame.add(representativeLabel);
        frame.add(dataLabel);
        frame.add(representativeDropdown);
        frame.add(dataDropdown);
        frame.add(updateButton);
        frame.add(registerClassButton);
        frame.add(registerClassroomButton);
    }

    private void setupActionListeners() {
        updateButton.addActionListener(this);
        registerClassButton.addActionListener(this);
        registerClassroomButton.addActionListener(this);
    }

    @Override
    public void actionPerformed(ActionEvent e) {
    	if (e.getSource() == updateButton) {
            // Get the selected representative and data to update
            String representativeName = (String) representativeDropdown.getSelectedItem();
            String[] names = representativeName.split("\\s+");
            String firstName = names[0];
            String lastName = names[1];
            String dataToUpdate = (String) dataDropdown.getSelectedItem();

            // Prompt for new value
            String newValue = JOptionPane.showInputDialog(frame, "Enter new value for " + dataToUpdate + ":");
            if (newValue != null && !newValue.isEmpty()) {
                // Perform the update
                updateRepresentativeData(firstName, lastName, dataToUpdate, newValue);
            }
        } else if (e.getSource() == registerClassButton) {
            // Open popup to register class
            String className = JOptionPane.showInputDialog(frame, "Enter Class Name:");
            if (className != null) {
                // Implement class registration here
                insertIntoClassesTable(className);
            }
        } else if (e.getSource() == registerClassroomButton) {
            // Open popup to register classroom
            JPanel panel = new JPanel();
            panel.setLayout(new BoxLayout(panel, BoxLayout.Y_AXIS));
            JTextField classNameField = new JTextField(10);
            JTextField capacityField = new JTextField(10);
            JTextField locationField = new JTextField(10);
            panel.add(new JLabel("Class Name:"));
            panel.add(classNameField);
            panel.add(new JLabel("Capacity:"));
            panel.add(capacityField);
            panel.add(new JLabel("Location:"));
            panel.add(locationField);
            int result = JOptionPane.showConfirmDialog(frame, panel, "Register Classroom", JOptionPane.OK_CANCEL_OPTION);
            if (result == JOptionPane.OK_OPTION) {
                String className = classNameField.getText();
                String capacity = capacityField.getText();
                String location = locationField.getText();
                // Implement classroom registration here
                insertIntoClassroomsTable(className, capacity, location);
            }
        }
    }

    private void insertIntoClassesTable(String className) {
        try (Connection conn = DriverManager.getConnection(url, UserN, PassD)) {
            String query = "INSERT INTO classes (class_name) VALUES (?)";
            try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setString(1, className);
                pstmt.executeUpdate();
                
                int inserted = pstmt.executeUpdate();

                if (inserted > 0) {
                    JOptionPane.showMessageDialog(null, "Insertion Successful!");
                    // Optionally, you can close the insert frame or perform other actions
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(frame, "Failed to register class!", "Error", JOptionPane.ERROR_MESSAGE);
        }
    }

    private void insertIntoClassroomsTable(String className, String capacity, String location) {
        try (Connection conn = DriverManager.getConnection(url, UserN, PassD)) {
            String query = "INSERT INTO classrooms (classroom_name, capacity, location) VALUES (?, ?, ?)";
            try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setString(1, className);
                pstmt.setString(2, capacity);
                pstmt.setString(3, location);
                pstmt.executeUpdate();
                
                int inserted = pstmt.executeUpdate();

                if (inserted > 0) {
                    JOptionPane.showMessageDialog(null, "Insertion Successful!");
                    // Optionally, you can close the insert frame or perform other actions
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(frame, "Failed to register classroom!", "Error", JOptionPane.ERROR_MESSAGE);
        }
    }
    private void populateRepresentativeDropdown() {
        try (Connection conn = DriverManager.getConnection(url, UserN, PassD)) {
            String query = "SELECT first_name, last_name FROM classrepresentatives";
            try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                ResultSet rs = pstmt.executeQuery();
                while (rs.next()) {
                    String firstName = rs.getString("first_name");
                    String lastName = rs.getString("last_name");
                    String fullName = firstName + " " + lastName;
                    representativeDropdown.addItem(fullName);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(frame, "Failed to populate representative dropdown!", "Error", JOptionPane.ERROR_MESSAGE);
        }
    }

    private void populateDataDropdown() {
        try (Connection conn = DriverManager.getConnection(url, UserN, PassD)) {
            DatabaseMetaData metaData = conn.getMetaData();
            ResultSet rs = metaData.getColumns(null, null, "classrepresentatives", null);
            while (rs.next()) {
                String columnName = rs.getString("COLUMN_NAME");
                if (!columnName.equalsIgnoreCase("rep_id")) {
                    dataDropdown.addItem(columnName);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(frame, "Failed to populate data dropdown!", "Error", JOptionPane.ERROR_MESSAGE);
        }
    }

    private void updateRepresentativeData(String firstName, String lastName, String dataToUpdate, String newValue) {
        try (Connection conn = DriverManager.getConnection(url, UserN, PassD)) {
            String query = "UPDATE classrepresentatives SET " + dataToUpdate + " = ? WHERE first_name = ? AND last_name = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(query)) {
                pstmt.setString(1, newValue);
                pstmt.setString(2, firstName);
                pstmt.setString(3, lastName);
                int rowsAffected = pstmt.executeUpdate();
                if (rowsAffected > 0) {
                    JOptionPane.showMessageDialog(frame, "Update successful!");
                } else {
                    JOptionPane.showMessageDialog(frame, "No rows updated.", "Warning", JOptionPane.WARNING_MESSAGE);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            JOptionPane.showMessageDialog(frame, "Failed to update data!", "Error", JOptionPane.ERROR_MESSAGE);
        }
    }

    public static void main(String[] args) {
        new coordinatorloggedin();
    }
}
