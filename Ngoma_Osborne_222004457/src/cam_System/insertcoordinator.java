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

public class insertcoordinator implements ActionListener {

    JFrame insertcoordinatorFrame;
    static final String JDBC_DRIVER = "your_jdbc_driver";
	String url = "jdbc:mysql://localhost:3306/Ngoma_Osborne_CAMS";
	String UserN = "222004457";
	String PassD = "222004457";

    JLabel insert = new JLabel("Insert a Coordinator");
    JLabel coordinatorNamelb = new JLabel("Coordinator Name");
    JLabel emaillb = new JLabel("Email");
    JLabel sexlb = new JLabel("Sex");
    JLabel phoneNumberlb = new JLabel("Phone Number");
    JLabel userNamelb = new JLabel("Username");
    JLabel passwordlb = new JLabel("Password");

    JTextField coordinatorNametxf = new JTextField();
    JTextField emailtxf = new JTextField();
    JTextField sextxf = new JTextField();
    JTextField phoneNumbertxf = new JTextField();
    JTextField userNametxf = new JTextField();
    JPasswordField passwordField = new JPasswordField();

    JButton insertbtn = new JButton("Insert");

    public insertcoordinator() {
        createForm();
        setLocationAndSize();
        addComponents();
        setupActionListeners();
    }

    private void createForm() {
        insertcoordinatorFrame = new JFrame();
        insertcoordinatorFrame.setTitle("Insert Portal");
        insertcoordinatorFrame.setBounds(550, 130, 500, 500);
        insertcoordinatorFrame.getContentPane().setLayout(null);
        insertcoordinatorFrame.getContentPane().setBackground(Color.white);
        insertcoordinatorFrame.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        insertcoordinatorFrame.setResizable(false);
        insertcoordinatorFrame.setVisible(true);
    }

    private void setLocationAndSize() {
        insert.setBounds(180, 20, 150, 30);
        coordinatorNamelb.setBounds(50, 60, 150, 30);
        emaillb.setBounds(50, 100, 150, 30);
        sexlb.setBounds(50, 140, 150, 30);
        phoneNumberlb.setBounds(50, 180, 150, 30);
        userNamelb.setBounds(50, 220, 150, 30);
        passwordlb.setBounds(50, 260, 150, 30);

        coordinatorNametxf.setBounds(200, 60, 250, 30);
        emailtxf.setBounds(200, 100, 250, 30);
        sextxf.setBounds(200, 140, 250, 30);
        phoneNumbertxf.setBounds(200, 180, 250, 30);
        userNametxf.setBounds(200, 220, 250, 30);
        passwordField.setBounds(200, 260, 250, 30);

        insertbtn.setBounds(190, 320, 120, 30);
    }

    private void addComponents() {
        insertcoordinatorFrame.add(insert);
        insertcoordinatorFrame.add(coordinatorNamelb);
        insertcoordinatorFrame.add(emaillb);
        insertcoordinatorFrame.add(sexlb);
        insertcoordinatorFrame.add(phoneNumberlb);
        insertcoordinatorFrame.add(userNamelb);
        insertcoordinatorFrame.add(passwordlb);

        insertcoordinatorFrame.add(coordinatorNametxf);
        insertcoordinatorFrame.add(emailtxf);
        insertcoordinatorFrame.add(sextxf);
        insertcoordinatorFrame.add(phoneNumbertxf);
        insertcoordinatorFrame.add(userNametxf);
        insertcoordinatorFrame.add(passwordField);

        insertcoordinatorFrame.add(insertbtn);
    }

    private void setupActionListeners() {
        insertbtn.addActionListener(this);
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        if (e.getSource() == insertbtn) {
            String coordinatorName = coordinatorNametxf.getText();
            String email = emailtxf.getText();
            String sex = sextxf.getText();
            String phoneNumber = phoneNumbertxf.getText();
            String username = userNametxf.getText();
            String password = new String(passwordField.getPassword());

            try (Connection conn = DriverManager.getConnection(url, UserN, PassD)) {
                // Insert into coordinators table
                String coordinatorSql = "INSERT INTO coordinators (coordinator_name, email, sex, phone_number) VALUES (?, ?, ?, ?)";
                try (PreparedStatement coordinatorStmt = conn.prepareStatement(coordinatorSql, Statement.RETURN_GENERATED_KEYS)) {
                    coordinatorStmt.setString(1, coordinatorName);
                    coordinatorStmt.setString(2, email);
                    coordinatorStmt.setString(3, sex);
                    coordinatorStmt.setString(4, phoneNumber);

                    int insertedRows = coordinatorStmt.executeUpdate();

                    if (insertedRows > 0) {
                        ResultSet generatedKeys = coordinatorStmt.getGeneratedKeys();
                        if (generatedKeys.next()) {
                            int coordinatorID = generatedKeys.getInt(1);

                            // Insert into users table
                            String userSql = "INSERT INTO users (username, password, user_type, user_reference_id) VALUES (?, ?, ?, ?)";
                            try (PreparedStatement userStmt = conn.prepareStatement(userSql)) {
                                userStmt.setString(1, username);
                                userStmt.setString(2, password);
                                userStmt.setString(3, "coordinator");
                                userStmt.setInt(4, coordinatorID);

                                int inserted = userStmt.executeUpdate();

                                if (inserted > 0) {
                                    JOptionPane.showMessageDialog(null, "Insertion Successful!");
                                    // Optionally, you can close the insert frame or perform other actions
                                } else {
                                    JOptionPane.showMessageDialog(null, "Failed to insert data into users table!");
                                }
                            }
                        }
                    } else {
                        JOptionPane.showMessageDialog(null, "Failed to insert data into coordinators table!");
                    }
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }

    public static void main(String[] args) {
        new insertcoordinator();
    }
}
