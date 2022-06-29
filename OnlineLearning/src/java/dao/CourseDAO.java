package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Account;
import model.Course;

public class CourseDAO extends DBContext {

    public int getNumberAllLessonInCourse(int accountID, int courseID) {
        int numLesson = -1;
        try {
            String sql = "SELECT COUNT(*) as NumAllLesson FROM Lesson l JOIN Course c\n"
                    + "ON c.CourseID = l.CourseID JOIN CourseAccount ca\n"
                    + "ON ca.CourseID = c.CourseID \n"
                    + "WHERE ca.AccountID = ? AND c.CourseID = ? AND l.LessonTypeID = 1";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, accountID);
            stm.setInt(2, courseID);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                numLesson = rs.getInt("NumAllLesson");
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return numLesson;
    }

    public int getNumberLessonLearning(int accountID, int courseID) {
        int numCurrentLesson = 0;
        try {
            String sql = "SELECT COUNT(*) as NumCurrentLesson FROM CompletedLesson cl JOIN Lesson l\n"
                    + "ON l.LessonID = cl.LessonID JOIN Course c\n"
                    + "ON c.CourseID = l.CourseID \n"
                    + "WHERE cl.AccountID = ? AND c.CourseID = ? AND l.lessonTypeID = 1";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, accountID);
            stm.setInt(2, courseID);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                numCurrentLesson = rs.getInt("NumCurrentLesson");
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return numCurrentLesson;
    }

    public Course getCourseByLessonID(int lessonID) {
        try {
            String sql = "select c.Name from lesson l join sublesson sl\n"
                    + "on l.SubLessonID = sl.SubLessonID join course c\n"
                    + "on c.CourseID = sl.CourseID where l.LessonID = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, lessonID);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Course course = new Course();
                course.setName(rs.getString("Name"));
                return course;
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public ArrayList<Course> getAllCourseBySubjectID(int subjectID, int status){
        ArrayList<Course> list = new ArrayList<>();
        try {
            String sql = "select c.*,a.FirstName, a.LastName, a.ProfilePictureUrl, a.Email from Course c, SubjectCourse sc, Account a "
                    + "where c.CourseID = sc.CourseID and a.AccountID = c.InstructorID and sc.SubjectID = ?";
            if(status != -1 ){
                sql += " and c.[Status] = ?";
            }
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, subjectID);
            if(status != -1 ){
                stm.setInt(2, status);
            }
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {                
                Course c = new Course();
                
                c.setCourseId(rs.getInt("CourseID"));
                c.setName(rs.getString("Name"));
                c.setPrice(rs.getBigDecimal("Price"));
                c.setStatus(rs.getBoolean("Status"));
                
                Account ac = new Account();
                ac.setFirstName(rs.getString("FirstName"));
                ac.setLastName(rs.getString("LastName"));
                ac.setEmail(rs.getString("Email"));
                ac.setProfilePictureUrl(rs.getString("ProfilePictureUrl"));
                
                c.setInstructorId(ac);
                
                list.add(c);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    public void deleteCourse(int id) {
        try {
            String sql = "DELETE [Course] WHERE [CourseID] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SubjectDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

        
    public int getlCourseIdsublessonID(int subLessonId){
        Course c = new Course();
        try {
            String sql = "  select s.CourseID from SubLesson s where s.SubLessonID = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, subLessonId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {        
                c.setCourseId(rs.getInt("CourseID"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return c.getCourseId();
    }
    
    
}

