package util;

import java.time.LocalDateTime;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import model.Account;
public class SessionUtil {
    public static Account getAccount(HttpServletRequest req) {
        Account acc = (Account) req.getSession().getAttribute("account");
        return acc;
    }
    
    public static LocalDateTime getStartQuiz(HttpServletRequest req, String str) {
        return (LocalDateTime) req.getSession().getAttribute(str);
    }
}
