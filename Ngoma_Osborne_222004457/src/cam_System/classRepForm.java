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
import javax.swing.JPasswordField;
import javax.swing.JTextField;
import javax.swing.WindowConstants;

public class classRepForm implements ActionListener{

    static final String JDBC_DRIVER = "your_jdbc_driver";
	String url = "jdbc:mysql://localhost:3306/Ngoma_Osborne_222004457";
	String UserN = "ngoma_osborne";
	String PassD = "222004457";
	//int loggedID;
	JFrame classrepF;
	
	JLabel wellb = new JLabel("Class representative's Portal");
	JLabel userName = new JLabel("Username: ");
	JLabel passW = new JLabel("Password: ");

	JTextField usertxf = new JTextField();
	JPasswordField passWtxf = new JPasswordField();

	JButton login = new JButton("LogIn");
	JButton signUp = new JButton("SignUp");
	JButton reset = new JButton("Reset");
	public classRepForm () {
		createform();
		setlocationandsize();
		addcomponent();
		setupActionListeners();
	}
	private void createform() {
		classrepF = new JFrame();
		classrepF.setTitle("Login Portal");
		classrepF.setBounds(600,140,500,350);
		classrepF.getContentPane().setLayout(null);
		classrepF.getContentPane().setBackground(Color.white);
		classrepF.setVisible(true);
		classrepF.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
		classrepF.setResizable(false);

	}
	private void setlocationandsize() {
		wellb.setBounds(195, 60, 200, 30);

		userName.setBounds(50, 110, 80, 30);
		usertxf.setBounds(140, 110, 250, 30);

		passW.setBounds(50, 150, 80, 30);
		passWtxf.setBounds(140, 150, 250, 30);

		login.setBounds(100, 250, 80, 30);
		reset.setBounds(200, 250, 80, 30);
		signUp.setBounds(300, 250, 80, 30);
	}
	private void addcomponent() {
		classrepF.add(wellb);
		classrepF.add(userName);
		classrepF.add(login);
		classrepF.add(passW);
		classrepF.add(reset);
		classrepF.add(signUp);
		classrepF.add(passWtxf);
		classrepF.add(usertxf);

	}
	private void setupActionListeners() {
	    login.addActionListener(this);
	    signUp.addActionListener(this);
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
                    pstmt.setString(3, "representative");
                    ResultSet resultSet = pstmt.executeQuery();
                    int rep_id = getrepIdFromDatabase(Username);
                    //System.out.println(rep_id);

                    if (resultSet.next()) {
                    	classrepF.dispose(); // Close the citizen frame
                        new classreploggedin(rep_id); // Open loggedForm
                    } else {
                        // Login failed
                        JOptionPane.showMessageDialog(null, "Invalid username or password!");
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
        if (e.getSource() == signUp) {
        	classrepF.dispose();
            new classRepSignupForm();
        }
    }
	private int getrepIdFromDatabase(String Username) {
        int repId = 0;
        try (Connection conn = DriverManager.getConnection(url, UserN, PassD)) {
            String sql = "SELECT user_reference_id FROM users WHERE username=? AND user_type = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, Username);
                pstmt.setString(2, "representative");
                ResultSet resultSet = pstmt.executeQuery();

                if (resultSet.next()) {
                    repId = resultSet.getInt("user_reference_id");
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return repId;
    }
	public static void main(String[] args) {
        new classRepForm();

	}
}

