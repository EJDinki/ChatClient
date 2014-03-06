/**
 * 
 */
package chat.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author Edward Dinki
 *
 */
public class ChatServlet extends HttpServlet {
    
    private static List<String> messages;
    private static int uid = 1;
    
    public ChatServlet()
    {
        messages = new ArrayList<String>();
        //Temp
        messages.add("Welcome to EJ's Chat Client!");
        messages.add("Type in the box and hit submit to start chatting.");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        /*
         * Check for chat updates
         * Generate HTML based off List of messages
         * put generated HTML onto request
         */

        trimMessages();
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        String chat = "{\"messages\":[";
        for(String s : messages)
        {
            chat += "\"" + s + "\",";
        }
        chat = chat.substring(0,chat.length() - 1);
        chat += "]}";

        out.print(chat);
        out.close();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        /*
         * Check for a new message coming in
         * Add message to List of messages
         * return success
         */

        if (request.getSession().getAttribute("uid") == null)
        {
            request.getSession().setAttribute("uid", uid);
            uid++;

        }
        int uid = (int) request.getSession().getAttribute("uid");

        String message = request.getParameter("message");
        String currTime = Calendar.getInstance().getTime().toString();
        String[] splitString = currTime.split(" ");
        String timeStamp = splitString[3];
        messages.add(timeStamp + " - " + "User ID = " + uid + ": " + message);
        trimMessages();

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        String chat = "{\"messages\":[";
        for(String s : messages)
        {
            chat += "\"" + s + "\",";
        }
        chat = chat.substring(0,chat.length() - 1);
        chat += "]}";

        out.print(chat);
        out.close();
    }
    
    private void trimMessages()
    {
       while(messages.size() > 50) 
       {
          messages.remove(0);
       }
    }
}
