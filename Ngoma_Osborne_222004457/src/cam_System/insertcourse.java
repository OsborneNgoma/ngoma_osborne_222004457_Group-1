package cam_System;
import java.awt.Color;
import java.awt.EventQueue;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.swing.*;

public class insertcourse {

    JFrame insertcourseFrame;
    static final String JDBC_DRIVER = "your_jdbc_driver";
	String url = "jdbc:mysql://localhost:3306/Ngoma_Osborne_CAMS";
	String UserN = "222004457";
	String PassD = "222004457";

    JLabel insert = new JLabel("Insert a Course");

    JLabel courseNamelb = new JLabel("Course Name");
    JLabel teacherIDlb = new JLabel("Teacher ID");
    JLabel creditslb = new JLabel("Credits");

    JTextField courseNametxf = new JTextField();
    JComboBox<String> teacherIDComboBox = new JComboBox<>();
    JTextField creditstxf = new JTextField();

    JButton insertbtn = new JButton("Insert");

    public insertcourse() {
        createForm();
        populateTeacherIDs();
        addComponents();
        setupActionListeners();
    }

    private void createForm() {
        insertcourseFrame = new JFrame();
        insertcourseFrame.setTitle("Insert Course");
        insertcourseFrame.setBounds(550, 130, 500, 420);
        insertcourseFrame.getContentPane().setLayout(new GridBagLayout());
        insertcourseFrame.getContentPane().setBackground(Color.white);
        insertcourseFrame.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        insertcourseFrame.setResizable(false);
        insertcourseFrame.setVisible(true);
    }

    private void setLocationAndSize(JComponent component, int gridx, int gridy, int gridwidth, int gridheight, int ipadx, int ipady) {
        GridBagConstraints constraints = new GridBagConstraints();
        constraints.gridx = gridx;
        constraints.gridy = gridy;
        constraints.gridwidth = gridwidth;
        constraints.gridheight = gridheight;
        constraints.ipadx = ipadx;
        constraints.ipady = ipady;
        constraints.fill = GridBagConstraints.HORIZONTAL;
        insertcourseFrame.getContentPane().add(component, constraints);
    }

    private void addComponents() {
        setLocationAndSize(insert, 0, 0, 2, 1, 0, 0);
        setLocationAndSize(courseNamelb, 0, 1, 1, 1, 0, 0);
        setLocationAndSize(teacherIDlb, 0, 2, 1, 1, 0, 0);
        setLocationAndSize(creditslb, 0, 3, 1, 1, 0, 0);

        setLocationAndSize(courseNametxf, 1, 1, 2, 1, 0, 0);
        setLocationAndSize(teacherIDComboBox, 1, 2, 2, 1, 0, 0);
        setLocationAndSize(creditstxf, 1, 3, 2, 1, 0, 0);

        setLocationAndSize(insertbtn, 1, 4, 1, 1, 0, 0);
    }

    private void setupActionListeners() {
        insertbtn.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String courseName = courseNametxf.getText();
                String teacherID = (String) teacherIDComboBox.getSelectedItem();
                String credits = creditstxf.getText();

                try (Connection conn = DriverManager.getConnection(url, UserN, PassD)) {
                    String courseSql = "INSERT INTO courses (course_name, Teachers_id, credits) VALUES (?, ?, ?)";
                    try (PreparedStatement courseStmt = conn.prepareStatement(courseSql, Statement.RETURN_GENERATED_KEYS)) {
                        courseStmt.setString(1, courseName);
                        courseStmt.setString(2, teacherID);
                        courseStmt.setString(3, credits);

                        int affectedRows = courseStmt.executeUpdate();

                        if (affectedRows > 0) {
                            JOptionPane.showMessageDialog(null, "Insertion Successful!");
                            // Optionally, you can close the insert frame or perform other actions
                        } else {
                            JOptionPane.showMessageDialog(null, "Failed to insert data!");
                        }
                    }
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        });
    }

    private void populateTeacherIDs() {
        try (Connection conn = DriverManager.getConnection(url, UserN, PassD);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT teacher_id FROM teachers")) {
            while (rs.next()) {
                teacherIDComboBox.addItem(rs.getString("teacher_id"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        EventQueue.invokeLater(new Runnable() {
            @Override
            public void run() {
                new insertcourse();
            }
        });
    }
}