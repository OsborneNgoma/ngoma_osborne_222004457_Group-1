package cam_System;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.swing.*;

public class classreploggedin implements ActionListener {

    JFrame crepLogINframe;
    static final String JDBC_DRIVER = "your_jdbc_driver";
    String url = "jdbc:mysql://localhost:3306/Ngoma_Osborne_222004457";
    String UserN = "ngoma_osborne";
    String PassD = "222004457";
    static int rep_id;

    JComboBox<String> classroomComboBox;
    JComboBox<String> classTimeComboBox;
    JButton requestButton;
    JLabel classTimeLabel, datePickedLabel;
    JComboBox<Integer> dayComboBox;
    JComboBox<String> monthComboBox;
    JComboBox<Integer> yearComboBox;
    JComboBox<String> courseComboBox;

    List<String> availableClassrooms = new ArrayList<>();
    List<String> availableCourses = new ArrayList<>();

    public classreploggedin(int rep_id) {
    	classreploggedin.rep_id = rep_id;
        createForm();
        setLocationAndSize();
        addComponents();
        setupActionListeners();
        populateDropdowns();
    }

    private void populateDropdowns() {
        try (Connection conn = DriverManager.getConnection(url, UserN, PassD)) {
            // Retrieve available classrooms not in timetables with the selected time range
            String classroomQuery = "SELECT c.classroom_name FROM classrooms c WHERE c.classroom_id NOT IN (SELECT t.classroom_id FROM timetables t WHERE t.time_range = ?)";
            try (PreparedStatement stmt = conn.prepareStatement(classroomQuery)) {
                String selectedClassTime = (String) classTimeComboBox.getSelectedItem();
                stmt.setString(1, selectedClassTime);
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    availableClassrooms.add(rs.getString("classroom_name"));
                }
            }

            // Clear existing items in courseComboBox before adding new ones
            courseComboBox.removeAllItems();

            // Retrieve available courses not in timetables with the selected time range
            String courseQuery = "SELECT c.course_name FROM courses c WHERE c.course_id NOT IN (SELECT t.course_id FROM timetables t WHERE t.time_range = ?)";
            try (PreparedStatement stmt = conn.prepareStatement(courseQuery)) {
                String selectedClassTime = (String) classTimeComboBox.getSelectedItem();
                stmt.setString(1, selectedClassTime);
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    availableCourses.add(rs.getString("course_name"));
                }
            }

        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        for (String classroom : availableClassrooms) {
            classroomComboBox.addItem(classroom);
        }
        for (String course : availableCourses) {
            courseComboBox.addItem(course);
        }
    }

    private void createForm() {
        crepLogINframe = new JFrame();
        crepLogINframe.setTitle("Class Representative Logged In");
        crepLogINframe.setBounds(450, 100, 600, 400);
        crepLogINframe.getContentPane().setLayout(null);
        crepLogINframe.setVisible(true);
        crepLogINframe.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        crepLogINframe.setResizable(false);
    }

    private void setLocationAndSize() {
        JLabel classroomLabel = new JLabel("Select Classroom:");
        classroomLabel.setBounds(50, 50, 150, 30);
        crepLogINframe.add(classroomLabel);

        classroomComboBox = new JComboBox<>();
        classroomComboBox.setBounds(200, 50, 200, 30);
        crepLogINframe.add(classroomComboBox);

        JLabel classTimeLabel = new JLabel("Select Class Time:");
        classTimeLabel.setBounds(50, 100, 150, 30);
        crepLogINframe.add(classTimeLabel);

        classTimeComboBox = new JComboBox<>();
        classTimeComboBox.addItem("8:30 - 12:00");
        classTimeComboBox.addItem("14:00 - 17:00");
        classTimeComboBox.setBounds(200, 100, 200, 30);
        crepLogINframe.add(classTimeComboBox);

        JLabel dateLabel = new JLabel("Date:");
        dateLabel.setBounds(50, 150, 150, 30);
        crepLogINframe.add(dateLabel);

        // Day ComboBox
        Integer[] days = new Integer[31];
        for (int i = 1; i <= 31; i++) {
            days[i - 1] = i;
        }
        dayComboBox = new JComboBox<>(days);
        dayComboBox.setBounds(200, 150, 60, 30);
        crepLogINframe.add(dayComboBox);

        // Month ComboBox
        String[] months = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
        monthComboBox = new JComboBox<>(months);
        monthComboBox.setBounds(270, 150, 100, 30);
        crepLogINframe.add(monthComboBox);

        // Year ComboBox
        Integer[] years = new Integer[30];
        int currentYear = java.time.Year.now().getValue();
        for (int i = 0; i < 30; i++) {
            years[i] = currentYear + i;
        }
        yearComboBox = new JComboBox<>(years);
        yearComboBox.setBounds(380, 150, 80, 30);
        crepLogINframe.add(yearComboBox);

        JLabel courseLabel = new JLabel("Select Course:");
        courseLabel.setBounds(50, 200, 150, 30);
        crepLogINframe.add(courseLabel);

        courseComboBox = new JComboBox<>();
        courseComboBox.setBounds(200, 200, 200, 30);
        crepLogINframe.add(courseComboBox);

        requestButton = new JButton("Request Class");
        requestButton.setBounds(180, 250, 200, 40);
        crepLogINframe.add(requestButton);

        datePickedLabel = new JLabel("");
        datePickedLabel.setBounds(50, 300, 500, 30); // Position for showing the date picked
        crepLogINframe.add(datePickedLabel);
    }

    private void addComponents() {
    }

    private void setupActionListeners() {
        requestButton.addActionListener(this);
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        if (e.getSource() == requestButton) {
            String selectedClassroom = (String) classroomComboBox.getSelectedItem();
            String selectedClassTime = (String) classTimeComboBox.getSelectedItem();
            int selectedDay = (int) dayComboBox.getSelectedItem();
            String selectedMonth = (String) monthComboBox.getSelectedItem();
            int selectedYear = (int) yearComboBox.getSelectedItem();
            String selectedCourse = (String) courseComboBox.getSelectedItem();
            //System.out.println(repId);
            int classid = getclassIdFromDatabase(rep_id);
            //System.out.println(rep_id);

            // Insert into timetable table
            try (Connection conn = DriverManager.getConnection(url, UserN, PassD)) {
                // Fetch course_id from courses table
                int courseId = getCourseId(selectedCourse, conn);
             // Fetch classroom_id from classrooms table
                int classroomId = getClassroomId(selectedClassroom, conn);

                String insertQuery = "INSERT INTO timetables (class_id, course_id, Date, time_range, classroom_id) VALUES (?, ?, ?, ?, ?)";
                try (PreparedStatement stmt = conn.prepareStatement(insertQuery)) {
                    stmt.setInt(1, classid);
                    stmt.setInt(2, courseId);
                    stmt.setString(3, selectedDay + " " + selectedMonth + " " + selectedYear);
                    stmt.setString(4, selectedClassTime);
                    stmt.setInt(5, classroomId); // Assuming you have the classroomId already
                    stmt.executeUpdate();
                }

                // Show confirmation message
                JOptionPane.showMessageDialog(crepLogINframe, "Class booked successfully.\nClassroom: " + selectedClassroom + "\nClass Time: " + selectedClassTime + "\nDate: " + selectedDay + " " + selectedMonth + " " + selectedYear + "\nCourse: " + selectedCourse, "Booking Confirmation", JOptionPane.INFORMATION_MESSAGE);
            } catch (SQLException ex) {
                ex.printStackTrace();
                JOptionPane.showMessageDialog(crepLogINframe, "An error occurred while booking the class. Please try again later.", "Error", JOptionPane.ERROR_MESSAGE);
            }

            datePickedLabel.setText("Date Picked: " + selectedDay + " " + selectedMonth + " " + selectedYear); // Display selected date
        }
        
    }

    private int getCourseId(String selectedCourse, Connection conn) throws SQLException {
        int courseId = 0;
        String query = "SELECT course_id FROM courses WHERE course_name = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, selectedCourse);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                courseId = rs.getInt("course_id");
            }
        }
        return courseId;
    }
    private int getClassroomId(String selectedClassroom, Connection conn) throws SQLException {
        int classroomId = 0;
        String query = "SELECT classroom_id FROM classrooms WHERE classroom_name = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, selectedClassroom);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                classroomId = rs.getInt("classroom_id");
            }
        }
        return classroomId;
    }
    private int getclassIdFromDatabase(int repId) {
        int classId = -1;
        try (Connection conn = DriverManager.getConnection(url, UserN, PassD)) {
            String sql = "SELECT class_id FROM classes WHERE rep_id=?";
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1, rep_id);
                ResultSet resultSet = pstmt.executeQuery();

                if (resultSet.next()) {
                    classId = resultSet.getInt("class_id"); // Correct the column name to "class_id"
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return classId;
    }
    private static int retrieverepId() {
        return rep_id;
    }

    public static void main(String[] args) {
    	int retreivedid = retrieverepId();
        new classreploggedin(retreivedid);
    }
}
