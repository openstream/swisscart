<!--
	//global variables
	var objRef;
	var strUrl;
	var strMode;
	
	// ///////////////////////////////////////////////////////////////
	// OpenSaferpayTerminal
	//
	// if java script is enabled this function sets a javascript code 
	// in the executive space of the open call or calls the 
	// OpenSaferpayTerminalWindow function directly (in case of BUTTON 
	// - works only with enabled java script)
	// ///////////////////////////////////////////////////////////////
	function OpenSaferpayTerminal(url, obj, mode) 
	{
		window.onerror = DoNothing;
		
		//open a window for these browsers
		if(1)
		{
			objRef = obj;
			strUrl = url;
			strMode = mode;
		
			if(mode == "LINK")
			{
				obj.href = "javascript:OpenSaferpayTerminalWindow()";
			}
			else if(mode == "FORM")
			{
				obj.action = "javascript:OpenSaferpayTerminalWindow()";
			}
			else if(mode == "BUTTON")
			{
				OpenSaferpayTerminalWindow();
			}
		}
	}

	// ///////////////////////////////////////////////////////////////
	// OpenSaferpayTerminalWindow
	//
	// the java script code that was set thru OpenSaferpayTerminal
	// function will call this function. OpenSaferpayTerminalWindow 
	// then creates the saferpay window.
	// ///////////////////////////////////////////////////////////////
	function OpenSaferpayTerminalWindow() 
	{
		window.onerror = DoNothing;

		//reset the url for the next click
		if(strMode == "LINK") objRef.href = strUrl;
		else if(strMode == "FORM") objRef.action  = strUrl;
		
		//add the standalone attribute to deliver the window state to the server
		if(strUrl.indexOf("WINDOWMODE=Standalone") == -1) strUrl += "&WINDOWMODE=Standalone";
	
		w = window.open(
			strUrl,
			'SaferpayTerminal',
			'scrollbars=1,resizable=0,toolbar=0,location=0,directories=0,status=1,menubar=0,width=580,height=400'
		);
		
		if (w)
			w.focus();
		else
			window.location.href = strUrl;
	}
	
	
	// ///////////////////////////////////////////////////////////////
	// OpenSaferpayWindowJScript(strUrl)
	//
	// this function provides the open window functionality for
	// using form javascript
	// ///////////////////////////////////////////////////////////////
	function OpenSaferpayWindowJScript(strUrl) 
	{
		window.onerror = DoNothing;
		
		//add the standalone attribute to deliver the window state to the server
		if(strUrl.indexOf("WINDOWMODE=Standalone") == -1) strUrl += "&WINDOWMODE=Standalone";
	
		w = window.open(
			strUrl,
			'SaferpayTerminal',
			'scrollbars=1,resizable=0,toolbar=0,location=0,directories=0,status=1,menubar=0,width=580,height=400'
		);
		
		if (w)
			w.focus();
		else
			window.location.href = strUrl;
	}

	// ///////////////////////////////////////////////////////////////
	// DoNothing
	//
	// error handler does nothing.
	// ///////////////////////////////////////////////////////////////
	function DoNothing(sMsg,sUrl,sLine)
	{
		//if the error handler returns true the error will not be 
		//displayed except InterDev error handling is enabled.
		return true;
	}

//-->