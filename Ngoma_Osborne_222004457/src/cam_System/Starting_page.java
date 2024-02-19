package cam_System;

import java.awt.Color;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.WindowConstants;

public class Starting_page implements ActionListener{
	JFrame logFm;
	JLabel wellb = new JLabel("Who Are you?");
	
	JButton teacherbtn = new JButton("Teacher");
	JButton classrepbtn = new JButton("Class Representative");
	JButton coordinatorbtn = new JButton("Coordinator");
	JButton Hodbtn = new JButton("HoD");

	public Starting_page() {
		createform();
		setlocationandsize();
		addcomponent();
		ActionEvent();
	}

	private void createform() {
		logFm = new JFrame();
		logFm.setTitle("CAM System");
		logFm.setBounds(600,140,500,330);
		logFm.getContentPane().setLayout(null);
		logFm.getContentPane().setBackground(Color.white);
		logFm.setVisible(true);
		logFm.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
		logFm.setResizable(false);

	}
	private void setlocationandsize() {
		wellb.setBounds(195, 40, 200, 30);
		classrepbtn.setBounds(155, 100, 160, 30);
		teacherbtn.setBounds(155, 140, 160, 30);
		coordinatorbtn.setBounds(155, 180, 160, 30);
		Hodbtn.setBounds(155, 220, 160, 30);
	}
	private void addcomponent() {
		logFm.add(wellb);
		logFm.add(teacherbtn);
		logFm.add(classrepbtn);
		logFm.add(coordinatorbtn);
		logFm.add(Hodbtn);
	}
	private void ActionEvent() {
		teacherbtn.addActionListener(this);
		classrepbtn.addActionListener(this);
		Hodbtn.addActionListener(this);
		coordinatorbtn.addActionListener(this);
	}
	@Override
	public void actionPerformed(java.awt.event.ActionEvent e) {
		if (e.getSource() == classrepbtn) {
            // Open CitizenForm when Citizen button is clicked
            logFm.dispose(); // Close the Start_Here frame
            new classRepForm(); // Open CitizenForm
        }
		if (e.getSource() == teacherbtn) {
            // Open CitizenForm when Citizen button is clicked
            logFm.dispose(); // Close the Start_Here frame
            new teacherForm(); // open StaffForm
        }
		if (e.getSource() == coordinatorbtn) {
            // Open CitizenForm when Citizen button is clicked
            logFm.dispose(); // Close the Start_Here frame
            new coordinatorForm(); // open StaffForm
        }
		if (e.getSource() == Hodbtn) {
            // Open CitizenForm when Citizen button is clicked
            logFm.dispose(); // Close the Start_Here frame
            new HodbForm(); // open StaffForm
        }
	}

	public static void main(String[] args) {
        new Starting_page();

	}


}
