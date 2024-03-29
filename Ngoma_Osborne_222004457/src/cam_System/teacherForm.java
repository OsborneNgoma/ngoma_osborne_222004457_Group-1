package cam_System;

import java.awt.Color;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JTextField;
import javax.swing.WindowConstants;

public class teacherForm implements ActionListener{

    static final String JDBC_DRIVER = "your_jdbc_driver";
	String url = "jdbc:mysql://localhost:3306/Ngoma_Osborne_CAMS";
	String UserN = "222004457";
	String PassD = "222004457";

    JFrame teacherframe;

    JLabel wellb = new JLabel("teacher's Portal");
    JLabel userName = new JLabel("Username: ");
    JLabel passW = new JLabel("Password: ");

    JTextField usertxf = new JTextField();
    JTextField passWtxf = new JTextField();

    JButton login = new JButton("LogIn");
    JButton reset = new JButton("Reset");

    public teacherForm () {
        createform();
        setlocationandsize();
        addcomponent();
        setupActionListeners();
    }

    private void createform() {
        teacherframe = new JFrame();
        teacherframe.setTitle("Login Portal");
        teacherframe.setBounds(600, 140, 500, 350);
        teacherframe.getContentPane().setLayout(null);
        teacherframe.getContentPane().setBackground(Color.white);
        teacherframe.setVisible(true);
        teacherframe.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        teacherframe.setResizable(false);
    }

    private void setlocationandsize() {
        wellb.setBounds(195, 60, 200, 30);

        userName.setBounds(50, 110, 80, 30);
        usertxf.setBounds(140, 110, 250, 30);

        passW.setBounds(50, 150, 80, 30);
        passWtxf.setBounds(140, 150, 250, 30);

        login.setBounds(100, 250, 80, 30);
        reset.setBounds(300, 250, 80, 30);
    }

    private void addcomponent() {
        teacherframe.add(wellb);
        teacherframe.add(userName);
        teacherframe.add(login);
        teacherframe.add(passW);
        teacherframe.add(reset);
        teacherframe.add(passWtxf);
        teacherframe.add(usertxf);
    }

    private void setupActionListeners() {
        login.addActionListener(this);
        reset.addActionListener(this);
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        if (e.getSource() == login) {
            String Username = usertxf.getText();
            String Password = passWtxf.getText();

            // Validate credentials by querying the database
            try (Connection conn = DriverManager.getConnection(url, UserN, PassD)) {
                String sql = "SELECT * FROM users WHERE username=? AND password=? AND user_type=?";
                try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                    pstmt.setString(1, Username);
                    pstmt.setString(2, Password);
                    pstmt.setString(3, "teacher"); // Only allow users with "hod" user type
                    ResultSet resultSet = pstmt.executeQuery();

                    if (resultSet.next()) {
                        teacherframe.dispose(); // Close the citizen frame
                        new teacherloggedin(); // Open loggedForm
                    } else {
                        // Login failed
                        JOptionPane.showMessageDialog(null, "Invalid username or password or user type!");
                    }
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        if (e.getSource() == reset) {
            usertxf.setText(""); 
            passWtxf.setText("");
        }
    }

    public static void main(String[] args) {
        new teacherForm();
    }
}
