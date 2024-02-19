package cam_System;

import java.awt.Color;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.swing.*;

public class insertTeachers  implements ActionListener {

    JFrame insertteacherFrame;
    static final String JDBC_DRIVER = "your_jdbc_driver";
    String url = "jdbc:mysql://localhost:3306/Ngoma_Osborne_222004457";
    String UserN = "ngoma_osborne";
    String PassD = "222004457";

    JLabel signup = new JLabel("Insert a teacher");

    JLabel fnamelb = new JLabel("First Name");
    JLabel emaillb = new JLabel("Email");
    JLabel sexlb = new JLabel("Sex");
    JLabel specializationlb = new JLabel("Specialization");
    JLabel userNamelb = new JLabel("Username");
    JLabel passwordlb = new JLabel("Password");

    JTextField fnametxf = new JTextField();
    JTextField emailtxf = new JTextField();
    JTextField sextxf = new JTextField();
    JTextField specializationtxf = new JTextField();
    JTextField userNametxf = new JTextField();
    JTextField passwordtxf = new JTextField();

    JButton SignUpbtn = new JButton("SignUp");

    public insertTeachers () {
        createform();
        setlocationandsize();
        addcomponent();
        setupActionListeners();
    }

    private void createform() {
        insertteacherFrame = new JFrame();
        insertteacherFrame.setTitle("Sign-Up Portal");
        insertteacherFrame.setBounds(550, 130, 500, 420);
        insertteacherFrame.getContentPane().setLayout(null);
        insertteacherFrame.getContentPane().setBackground(Color.white);
        insertteacherFrame.setVisible(true);
        insertteacherFrame.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        insertteacherFrame.setResizable(false);
    }

    private void setlocationandsize() {
        signup.setBounds(180, 50, 90, 30);
        fnamelb.setBounds(50, 100, 90, 30);
        emaillb.setBounds(50, 140, 90, 30);
        sexlb.setBounds(50, 180, 90, 30);
        specializationlb.setBounds(50, 220, 90, 30);
        userNamelb.setBounds(50, 260, 90, 30);
        passwordlb.setBounds(50, 300, 90, 30);

        fnametxf.setBounds(170, 100, 250, 30);
        emailtxf.setBounds(170, 140, 250, 30);
        sextxf.setBounds(170, 180, 250, 30);
        specializationtxf.setBounds(170, 220, 250, 30);
        userNametxf.setBounds(170, 260, 250, 30);
        passwordtxf.setBounds(170, 300, 250, 30);

        SignUpbtn.setBounds(190, 340, 90, 30);
    }

    private void addcomponent() {
        insertteacherFrame.add(signup);
        insertteacherFrame.add(fnamelb);
        insertteacherFrame.add(emaillb);
        insertteacherFrame.add(sexlb);
        insertteacherFrame.add(specializationlb);
        insertteacherFrame.add(userNamelb);
        insertteacherFrame.add(passwordlb);

        insertteacherFrame.add(fnametxf);
        insertteacherFrame.add(emailtxf);
        insertteacherFrame.add(sextxf);
        insertteacherFrame.add(specializationtxf);
        insertteacherFrame.add(userNametxf);
        insertteacherFrame.add(passwordtxf);

        insertteacherFrame.add(SignUpbtn);
    }

    private void setupActionListeners() {
        SignUpbtn.addActionListener(this);
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        if (e.getSource() == SignUpbtn) {
            String firstName = fnametxf.getText();
            String email = emailtxf.getText();
            String sex = sextxf.getText();
            String specialization = specializationtxf.getText();
            String username = userNametxf.getText();
            String password = passwordtxf.getText();

            try (Connection conn = DriverManager.getConnection(url, UserN, PassD)) {
                String checkUsernameQuery = "SELECT * FROM users WHERE Username = ?";
                try (PreparedStatement checkUsernameStmt = conn.prepareStatement(checkUsernameQuery)) {
                    checkUsernameStmt.setString(1, username);
                    ResultSet usernameResult = checkUsernameStmt.executeQuery();

                    if (usernameResult.next()) {
                        JOptionPane.showMessageDialog(null, "Username already in use!");
                    } else {
                        String teacherSql = "INSERT INTO teachers (Name, email, sex, specialization) VALUES (?, ?, ?, ?)";
                        try (PreparedStatement teacherStmt = conn.prepareStatement(teacherSql, Statement.RETURN_GENERATED_KEYS)) {
                            teacherStmt.setString(1, firstName);
                            teacherStmt.setString(2, email);
                            teacherStmt.setString(3, sex);
                            teacherStmt.setString(4, specialization);

                            int affectedRows = teacherStmt.executeUpdate();

                            if (affectedRows > 0) {
                                ResultSet generatedKeys = teacherStmt.getGeneratedKeys();
                                if (generatedKeys.next()) {
                                    int teacherID = generatedKeys.getInt(1);

                                    String loginSql = "INSERT INTO users (Username, Password, user_type, user_reference_id) VALUES (?, ?, ?, ?)";
                                    try (PreparedStatement loginStmt = conn.prepareStatement(loginSql)) {
                                        loginStmt.setString(1, username);
                                        loginStmt.setString(2, password);
                                        loginStmt.setString(3, "Teacher");
                                        loginStmt.setInt(4, teacherID);

                                        int inserted = loginStmt.executeUpdate();

                                        if (inserted > 0) {
                                            JOptionPane.showMessageDialog(null, "Insertion Successful!");
                                            // Optionally, you can close the signup frame or perform other actions
                                        } else {
                                            JOptionPane.showMessageDialog(null, "Failed to insert login credentials!");
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }

    public static void main(String[] args) {
        new insertTeachers ();
    }
}
