package cam_System;

import javax.swing.*;
import java.awt.*;


public class menu_form extends JFrame{

	private JButton btnDepartment, btnClassRepresentatives, btnCoordinators, btnHODs, btnTimetables, btnCourses,
	btnTeachers, btnClassrooms, btnBookingRecords, btnAuditLog, btnUserLoginData;

	public menu_form() {
		setTitle("Database Management System");
		setSize(400, 500);
		setDefaultCloseOperation(EXIT_ON_CLOSE);
		setLocationRelativeTo(null);

		JPanel panel = new JPanel();
		panel.setLayout(new GridLayout(11, 1));

		btnDepartment = new JButton("Department Table");
		btnClassRepresentatives = new JButton("Class Representatives Table");
		btnCoordinators = new JButton("Coordinators Table");
		btnHODs = new JButton("HODs Table");
		btnTimetables = new JButton("Timetables Table");
		btnCourses = new JButton("Courses Table");
		btnTeachers = new JButton("Teachers Table");
		btnClassrooms = new JButton("Classrooms Table");
		btnBookingRecords = new JButton("Booking Records Table");
		btnAuditLog = new JButton("Audit Log Table");
		btnUserLoginData = new JButton("User Login Data Table");

		panel.add(btnDepartment);
		panel.add(btnClassRepresentatives);
		panel.add(btnCoordinators);
		panel.add(btnHODs);
		panel.add(btnTimetables);
		panel.add(btnCourses);
		panel.add(btnTeachers);
		panel.add(btnClassrooms);
		panel.add(btnBookingRecords);
		panel.add(btnAuditLog);
		panel.add(btnUserLoginData);

		add(panel);
	}

	public static void main(String[] args) {
		menu_form menuForm = new menu_form();
		menuForm.setVisible(true);
	}
}

