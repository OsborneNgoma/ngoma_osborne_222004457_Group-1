package cam_System;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.*;

public class teacherloggedin implements ActionListener {
    JFrame telooginF;

    static final String JDBC_DRIVER = "your_jdbc_driver";
	String url = "jdbc:mysql://localhost:3306/Ngoma_Osborne_CAMS";
	String UserN = "222004457";
	String PassD = "222004457";

    JLabel wellb = new JLabel("Welcome");
    JLabel enterlb = new JLabel("Enter Course Name:");
    JComboBox<String> courseComboBox = new JComboBox<>();
    JButton viewButton = new JButton("View");

    public teacherloggedin() {
        createForm();
        setLocationAndSize();
        addComponents();
        setupActionListeners();
        populateDropdown();
    }

    private void populateDropdown() {
        try (Connection conn = DriverManager.getConnection(url, UserN, PassD)) {
            String query = "SELECT course_name FROM courses";
            try (PreparedStatement stmt = conn.prepareStatement(query)) {
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    courseComboBox.addItem(rs.getString("course_name"));
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    private void createForm() {
        telooginF = new JFrame();
        telooginF.setTitle("Teacher Logged In");
        telooginF.setBounds(450, 100, 600, 260);
        telooginF.getContentPane().setLayout(null);
        telooginF.setVisible(true);
        telooginF.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        telooginF.setResizable(false);
    }

    private void setLocationAndSize() {
        wellb.setBounds(50, 50, 150, 30);
        telooginF.add(wellb);

        enterlb.setBounds(50, 100, 150, 30);
        telooginF.add(enterlb);

        courseComboBox.setBounds(200, 100, 200, 30);
        telooginF.add(courseComboBox);

        viewButton.setBounds(200, 150, 100, 30);
        telooginF.add(viewButton);
    }

    private void addComponents() {
    }

    private void setupActionListeners() {
        viewButton.addActionListener(this);
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        if (e.getSource() == viewButton) {
            String selectedCourse = (String) courseComboBox.getSelectedItem();
            try (Connection conn = DriverManager.getConnection(url, UserN, PassD)) {
                String query = "SELECT t.Date, t.time_range, c.class_name, cr.first_name, cr.last_name, cr.email, cr.phone_number, cl.classroom_name, cl.location FROM timetables t JOIN classes c ON t.class_id = c.class_id JOIN classrepresentatives cr ON c.rep_id = cr.rep_id JOIN classrooms cl ON t.classroom_id = cl.classroom_id WHERE t.course_id = (SELECT course_id FROM courses WHERE course_name = ?)";
                try (PreparedStatement stmt = conn.prepareStatement(query)) {
                    stmt.setString(1, selectedCourse);
                    ResultSet rs = stmt.executeQuery();
                    if (rs.next()) {
                        String date = rs.getString("Date");
                        String timeRange = rs.getString("time_range");
                        String className = rs.getString("class_name");
                        String repFirstName = rs.getString("first_name");
                        String repLastName = rs.getString("last_name");
                        String repEmail = rs.getString("email");
                        String repPhoneNumber = rs.getString("phone_number");
                        String classroomName = rs.getString("classroom_name");
                        String location = rs.getString("location");

                        // Display retrieved information in a popup dialog
                        String message = "Course Name: " + selectedCourse + "\n" +
                                         "Class Name: " + className + "\n" +
                                         "Class Representative: " + repFirstName + " " + repLastName + " (" + repEmail + ")\n" +
                                         "Phone Number: " + repPhoneNumber + "\n" +
                                         "Classroom: " + classroomName + " (" + location + ")\n" +
                                         "Time Range: " + timeRange + "\n" +
                                         "Date: " + date;
                        JOptionPane.showMessageDialog(telooginF, message, "Class Information", JOptionPane.INFORMATION_MESSAGE);
                    } else {
                        JOptionPane.showMessageDialog(telooginF, "No information found for the selected course.", "No Data", JOptionPane.WARNING_MESSAGE);
                    }
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
                JOptionPane.showMessageDialog(telooginF, "An error occurred while fetching data from the database.", "Error", JOptionPane.ERROR_MESSAGE);
            }
        }
    }

    public static void main(String[] args) {
        new teacherloggedin();
    }
}
