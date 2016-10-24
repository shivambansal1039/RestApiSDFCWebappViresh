package com.controller;

import java.io.IOException;
import java.security.Principal;
import java.security.SecureRandom;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.bouncycastle.util.encoders.Base64;
//import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.force.api.QueryResult;
import com.model.ContactModel;
import com.service.SalesForceApi;

@Controller
public class BaseController {

	private static int counter = 0;
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public ModelAndView welcome(ModelAndView mav) {
		
		QueryResult<Map> res = SalesForceApi.getForceApi().query("SELECT Id, Name, MobilePhone, Email FROM Contact");
		List<ContactModel> contactModels = new LinkedList<ContactModel>();
		for (Map resMap : res.getRecords()) {
			Iterator it = resMap.entrySet().iterator();
			ContactModel contactModel = new ContactModel();
			it.next(); // Skip attributes
			contactModel.setId(getValue(it.next().toString()));
			contactModel.setName(getValue(it.next().toString()));
			contactModel.setMobilePhone(getValue(it.next().toString()));
			contactModel.setEmail(getValue(it.next().toString()));
			contactModels.add(contactModel);
		}
		
		/*mav.getModel().put("message", "Welcome");
		mav.getModel().put("counter", ++counter);*/
		mav.getModel().put("contacts", contactModels);
		
	   // Spring uses InternalResourceViewResolver and return back index.jsp
		return mav;

	}

	private String getValue(String str) {
		return str.substring(str.indexOf("=") + 1);
	}
	
	@RequestMapping(value = "/createContact", method = RequestMethod.POST)
	public void createContact(HttpServletRequest request, HttpServletResponse response,  Principal principal) throws IOException,Exception {
		String fname = request.getParameter("fname");
		
		String lname = request.getParameter("lname");
		String mobilephone = request.getParameter("mobilephone");
		String email = request.getParameter("email");
		
	      Map<String, Object> newContact = new HashMap<String, Object>();
	      try{
	    	  newContact.put("FirstName", fname);
		      newContact.put("LastName", lname);
		      newContact.put("MobilePhone", mobilephone);
		      newContact.put("Email",email);
	          String id = SalesForceApi.getForceApi().createSObject("Contact", newContact);

	      	}
	      catch(Exception ex){
	    	  
	      }
		
		response.setStatus(200);
		
	}
	
	@RequestMapping(value = "/updateContact", method = RequestMethod.POST)
	public void updateContact(HttpServletRequest request, HttpServletResponse response,  Principal principal) throws IOException,Exception {
		String id = request.getParameter("id");
		String fname = request.getParameter("fnameupdate");
		String lname = request.getParameter("lnameupdate");
		String mobilephone = request.getParameter("mobilephoneupdate");
		String email = request.getParameter("emailupdate");
	      Map<String, Object> updateContact = new HashMap<String, Object>();
	      try{
	    	  updateContact.put("FirstName", fname);
	    	  updateContact.put("LastName", lname);
	    	  updateContact.put("MobilePhone", mobilephone);
	    	  updateContact.put("Email",email);
	          SalesForceApi.getForceApi().updateSObject("Contact", id, updateContact);
	      	}
	      catch(Exception ex){
	    	  
	      }
		response.setStatus(200);
	}
	
	
	
	@RequestMapping(value = "/deleteContact", method = RequestMethod.POST)
	public void deleteContact(HttpServletRequest request, HttpServletResponse response,  Principal principal) throws IOException,Exception {
		
		String id = request.getParameter("id");
		SalesForceApi.getForceApi().deleteSObject("Contact", id);
		response.setStatus(200);
		
	}
}