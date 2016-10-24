<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
 
<title>Rest-Api Demo By Viresh</title>            
<body>
<c:url value="/createContact.htm" var="createContact"/>
<c:url value="/updateContact.htm" var="updateContact"/>
<c:url value="/deleteContact.htm" var="deleteContact"/>
<script type="text/javascript">
	
        $(document).ready(function(){

                 
            $('form[name=createContact]').submit(function(e) {
                e.preventDefault();
                     $.ajax({
                        type: 'POST',
                        cache: false,
                        url: '${createContact}',
                        data: $(this).serialize(),
                        success: function(msg) {
                          alert('Contact created successfully');      
				setTimeout(function(){
     				  window.location.reload();
      				}, 1000);
                        },
                        error: function(msg){
                          alert('Contact createtion failed');
				setTimeout(function(){
     				  window.location.reload();
      				}, 1000);
                        }
                     	
                    }); 
            });

            $('form[name=updateContact]').submit(function(e) {
                e.preventDefault();
                     $.ajax({
                        type: 'POST',
                        cache: false,
                        url: '${updateContact}',
                        data: $(this).serialize(),
                        success: function(msg) {
                          alert('Contact updated successfully');    
				setTimeout(function(){
     				  window.location.reload();
      				}, 1000);
                        },
                        error: function(msg){
                          alert('Contact updation failed');
				setTimeout(function(){
     				  window.location.reload();
      				}, 1000);
                        }
                     	
                    }); 
            });

            $('#delete').click(function(){
            	$.ajax({
                    type: 'POST',
                    cache: false,
                    url: '${deleteContact}?id='+tatid,
                    data: $(this).serialize(),
                    success: function(msg) {
                      alert('Contact deleted successfully');                         
                    },
                    error: function(msg){
                      alert('Contact deletion failed');
                    }
                 	
                }); 
            });
        });


        function deleteContact(contactId){
        	  $.ajax({
                  type: 'POST',
                  cache: false,
                  url: '${deleteContact}?id='+contactId,
                  data: $(this).serialize(),
                  success: function(msg) {
                    alert('Contact deleted successfully');
			  setTimeout(function(){
     				  window.location.reload();
      				}, 1000);
                  },
                  error: function(msg){
                    alert('Contact deletion failed');
			  setTimeout(function(){
     				  window.location.reload();
      				}, 1000);
                  }
               	
              }); 
        }

        function createContact(){
			$('#update-contact').hide();
			$('#create-contact').show();
		}
		
        function updateContact(contactId){
			$('#update-contact').show();
			$('#create-contact').hide();

			var str =$('#'+contactId).find('.name').text();
			var ret = str.split(" ");
		
			$('#id').val($('#'+contactId).find('.id').text());
			$('#fnameupdate').val(ret[0]);
			$('#lnameupdate').val(ret[1]);
			$('#mobilephoneupdate').val($('#'+contactId).find('.mobilePhone').text());
			$('#emailupdate').val($('#'+contactId).find('.email').text());
		 	$(window).scrollTop(0);
		}
</script>
<a href="javascript:createContact();"><b>Create New Contact</b></a><hr>
<form name="updateContact" id="update-contact" style="display: none;">
        <h3>Update Contact</h3>
        <div class="fields">
        <input type="hidden" id="id" name="id" value=""/>
            <div class="field field-name">
                <label for="fnameupdate">First Name</label>
                <input type="text" id="fnameupdate" name="fnameupdate"tabindex="1" />
            </div>
            <div class="field field-name">
                <label for="lnameupdate">Last Name</label>
                <input type="text" id="lnameupdate" name="lnameupdate" tabindex="2" required/>
            </div>
            <div class="field field-name">
                <label for="mobilephoneupdate">Mobile Phone</label>
                <input type="text" id="mobilephoneupdate" name="mobilephoneupdate" tabindex="3" />
            </div>
            <div class="field field-name">
                <label for="emailupdate">Email</label>
                <input type="text" id="emailupdate" name="emailupdate" tabindex="4" />
            </div>
        </div>
        <div class="submit">
            <input type="submit" value="Update" tabindex="5">
	    </div>
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
</form> 

<form name="createContact" id="create-contact" style="display: none;">
        <h3>Create Contact</h3>
        <div class="fields">
            <div class="field field-name">
                <label for="fname">First Name</label>
                <input type="text" id="fname" name="fname"tabindex="1" />
            </div>
            <div class="field field-name">
                <label for="lname">Last Name</label>
                <input type="text" id="lname" name="lname" tabindex="2" required/>
            </div>
            <div class="field field-name">
                <label for="mobilephone">Mobile Phone</label>
                <input type="text" name="mobilephone" tabindex="3" />
            </div>
            <div class="field field-name">
                <label for="email">Email</label>
                <input type="text" name="email" tabindex="4" />
            </div>
        </div>
        <div class="submit">
            <input type="submit" value="Create" tabindex="5" class="active">
			<%--<input type="button" id="cancleUpdateProfile"  value="<spring:message code='label.Cancel'/>" class="cancel"> --%>
        </div>
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
</form> 

<hr>
<table class="table">
    <thead>
      <tr>
        <th>Id</th>
        <th>Name</th>
        <th>Mobile Phone</th>
        <th>Email</th>
      </tr>
    </thead>
    <tbody>
    <c:forEach items="${contacts}" var="con">
      <a href="javascript:updateContact('${con.id}','${con.name}','${con.mobilePhone}','${con.email}');">
      <tr id='${con.id}'>
        <td class='id'>${con.id}</td>
        <td class='name'>${con.name}</td>
        <td class='mobilePhone'>${con.mobilePhone}</td>
        <td class='email'>${con.email}</td>
        <td><a id="delete" href="javascript:deleteContact('${con.id}');">Delete</a></td>
        <td><a id="update" href="javascript:updateContact('${con.id}');">Update</a></td>
      </tr>
      </a>
    </c:forEach>
    </tbody>
  </table>


</body>
</html>
