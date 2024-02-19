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

public class classRepSignupForm implements ActionListener {
    JFrame crepfr = new JFrame();
    static final String JDBC_DRIVER = "your_jdbc_driver";
    String url = "jdbc:mysql://localhost:3306/Ngoma_Osborne_222004457";
    String UserN = "ngoma_osborne";
    String PassD = "222004457";

    JLabel signup = new JLabel("SignUp-Portal");

    JLabel fnamelb = new JLabel("First Name");
    JLabel lnamelb = new JLabel("Last Name");
    JLabel pnumberlb = new JLabel("Phone-number");
    JLabel emaillb = new JLabel("Email");
    JLabel classlb = new JLabel("Class");

    JLabel userNamelb = new JLabel("Username");
    JLabel passwordlb = new JLabel("Password");

    JTextField fnametxf = new JTextField();
    JTextField lnametxf = new JTextField();
    JTextField pnumbertxf = new JTextField();
    JTextField emailtxf = new JTextField();

    JTextField userNametxf = new JTextField();
    JPasswordField passwordtxf = new JPasswordField();

    JButton SignUpbtn = new JButton("SignUp");

    JComboBox<String> classDropdown = new JComboBox<>();

    public classRepSignupForm() {
        createForm();
        setLocationAndSize();
        addComponents();
        setupActionListeners();
        populateClassDropdown();
    }

    private void populateClassDropdown() {
        try (Connection conn = DriverManager.getConnection(url, UserN, PassD);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT class_name FROM classes WHERE rep_id IS NULL")) {

            while (rs.next()) {
                classDropdown.addItem(rs.getString("class_name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void createForm() {
        crepfr = new JFrame();
        crepfr.setTitle("Sign-Up Portal");
        crepfr.setBounds(550, 130, 500, 490);
        crepfr.getContentPane().setLayout(null);
        crepfr.getContentPane().setBackground(Color.white);
        crepfr.setVisible(true);
        crepfr.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        crepfr.setResizable(false);
    }

    private void setLocationAndSize() {
        signup.setBounds(180, 50, 90, 30);
        fnamelb.setBounds(50, 100, 90, 30);
        lnamelb.setBounds(50, 140, 90, 30);
        pnumberlb.setBounds(50, 180, 90, 30);
        emaillb.setBounds(50, 220, 90, 30);
        classlb.setBounds(50, 260, 90, 30);

        userNamelb.setBounds(50, 300, 90, 30);
        passwordlb.setBounds(50, 340, 90, 30);

        fnametxf.setBounds(170, 100, 250, 30);
        lnametxf.setBounds(170, 140, 250, 30);
        pnumbertxf.setBounds(170, 180, 250, 30);
        emailtxf.setBounds(170, 220, 250, 30);
        classDropdown.setBounds(170, 260, 250, 30);

        userNametxf.setBounds(170, 300, 250, 30);
        passwordtxf.setBounds(170, 340, 250, 30);

        SignUpbtn.setBounds(190, 390, 90, 30);
    }

    private void addComponents() {
        crepfr.add(signup);
        crepfr.add(fnamelb);
        crepfr.add(lnamelb);
        crepfr.add(passwordlb);
        crepfr.add(pnumberlb);
        crepfr.add(userNamelb);
        crepfr.add(emaillb);
        crepfr.add(classlb);
        crepfr.add(fnametxf);
        crepfr.add(lnametxf);
        crepfr.add(passwordtxf);
        crepfr.add(pnumbertxf);
        crepfr.add(userNametxf);
        crepfr.add(emailtxf);
        crepfr.add(classDropdown);
        crepfr.add(SignUpbtn);
    }

    private void setupActionListeners() {
        SignUpbtn.addActionListener(this);
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        if (e.getSource() == SignUpbtn) {
            String firstName = fnametxf.getText();
            String lastName = lnametxf.getText();
            String phoneNumber = pnumbertxf.getText();
            String email = emailtxf.getText();
            String className = (String) classDropdown.getSelectedItem();
            String username = userNametxf.getText();
            String password = passwordtxf.getText();

            try (Connection conn = DriverManager.getConnection(url, UserN, PassD)) {
                conn.setAutoCommit(false);

                // Fetch class_id based on class_name
                String getClassIdQuery = "SELECT class_id FROM classes WHERE class_name = ?";
                try (PreparedStatement getClassIdStmt = conn.prepareStatement(getClassIdQuery)) {
                    getClassIdStmt.setString(1, className);
                    ResultSet rs = getClassIdStmt.executeQuery();
                    if (rs.next()) {
                        int classId = rs.getInt("class_id");

                        // Insert into classrepresentatives table
                        String insertRepQuery = "INSERT INTO classrepresentatives (first_name, last_name, phone_number, email, class_id) VALUES (?, ?, ?, ?, ?)";
                        try (PreparedStatement insertRepStmt = conn.prepareStatement(insertRepQuery, Statement.RETURN_GENERATED_KEYS)) {
                            insertRepStmt.setString(1, firstName);
                            insertRepStmt.setString(2, lastName);
                            insertRepStmt.setString(3, phoneNumber);
                            insertRepStmt.setString(4, email);
                            insertRepStmt.setInt(5, classId);

                            int insertedRows = insertRepStmt.executeUpdate();
                            if (insertedRows == 0) {
                                throw new SQLException("Insert into classrepresentatives failed, no rows affected.");
                            }

                            ResultSet generatedKeys = insertRepStmt.getGeneratedKeys();
                            if (generatedKeys.next()) {
                                int repId = generatedKeys.getInt(1);

                                // Insert into users table
                                String insertUserQuery = "INSERT INTO users (username, password, user_type, user_reference_id) VALUES (?, ?, ?, ?)";
                                try (PreparedStatement insertUserStmt = conn.prepareStatement(insertUserQuery)) {
                                    insertUserStmt.setString(1, username);
                                    insertUserStmt.setString(2, password);
                                    insertUserStmt.setString(3, "representative");
                                    insertUserStmt.setInt(4, repId);

                                    insertedRows = insertUserStmt.executeUpdate();
                                    if (insertedRows == 0) {
                                        throw new SQLException("Insert into users failed, no rows affected.");
                                    }
                                }
                            } else {
                                throw new SQLException("Insert into classrepresentatives failed, no ID obtained.");
                            }
                        }
                    } else {
                        throw new SQLException("Class not found.");
                    }
                    conn.commit();
                    JOptionPane.showMessageDialog(null, "Signup Successful!");
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
                JOptionPane.showMessageDialog(null, "Failed to sign up!");
            }
        }
    }

    public static void main(String[] args) {
        new classRepSignupForm();
    }
}
