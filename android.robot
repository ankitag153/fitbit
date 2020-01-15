*** Settings ***
Documentation 		  Data Driven Test
Library               AppiumLibrary       15      run_on_failure=Log Source
Library               Process
Suite Setup           Spawn Appium Server and Application
Suite Teardown        Close Application
Test Template		  Login with Valid or Invalid Credentials

*** Variables ***
${APPIUM_PORT}            4723
${APP_PACKAGE}            com.fitbit.FitbitMobile
${APP_ACTIVITY}           com.fitbit.FirstActivity
${APPIUM_SERVER}          http://127.0.0.1:${APPIUM_PORT}/wd/hub
${BOOTSTRAP_PORT}         4724
${PLATFORM}               Android
${VERSION}                7.0
${UDID}                   emulator-5554
${ALIAS}				  Pixel_3_API_24
${Loginlocator}		        id=com.fitbit.FitbitMobile:id/btn_log_in
${emailInputlocator}        id=com.fitbit.FitbitMobile:id/login_email
${passwordinputlocator}     id=com.fitbit.FitbitMobile:id/login_password
${LoginButtonlocator}		id=com.fitbit.FitbitMobile:id/login_button
${OkButtonlocator}		    id=android:id/button1
${VALID_USER}				test.user3457@gmail.com
${VALID_PASSWORD}			Password@123
${ErrorLocator}				id=android:id/message

*** Keywords ***

Login with Valid or Invalid Credentials
  [Arguments]		${user_name}		${password}
  Input Username	${user_name}
  Input Password  ${password}
  Submit Credentials
  Click Element		${OkButtonlocator}
  
Submit Credentials
  Click Element		${LoginButtonlocator}
  Capture Page Screenshot
  
Input Username
  [Arguments]		${username}    ${LocatorWaitTime}=10
  Wait Until Element Is Visible		${emailInputlocator}		${LocatorWaitTime}
  Clear Text        ${emailInputlocator}
  Input Text        ${emailInputlocator}     ${username}

Input Password
  [Arguments]		${password}
  Clear Text        ${passwordinputlocator}
  Input Text		${passwordinputlocator}  ${password}
  Capture Page Screenshot
  
  
Spawn Appium Server and Application

  Start Process  appium  -p  ${APPIUM_PORT}  -bp  ${BOOTSTRAP_PORT}   shell=true
  Open Application  ${APPIUM_SERVER}  platformName=${PLATFORM}  platformVersion=${VERSION}  udid=${UDID}  deviceName=${ALIAS}  appPackage=${APP_PACKAGE}  appActivity=${APP_ACTIVITY}
  Click Element		${Loginlocator}

	

*** Test Cases ***				USER_NAME		PASSWORD
Invalid Username				invalid			$(VALID_PASSWORD)
Invalid Password				${VALID_USER}	invalid
Invalid Username and Password	invalid			testpassword
Empty Username					${EMPTY}		$(VALID_PASSWORD)
Empty Password					${VALID_USER}	${EMPTY}
Empty Username and Password		${EMPTY}		${EMPTY}
Correct Username and Password	${VALID_USER}   $(VALID_PASSWORD)


	
