function Navigation() {
	var self = this;
	
	self.changeLanguage = function(){
		languageButton = $('#languageButton');
		currentLanguage = languageButton.text();
		if(currentLanguage == "de"){
			languageButton.text("en");
			document.cookie = "lang=en; path=/";
		}else{
			languageButton.text("de");
			document.cookie = "lang=de; path=/";
		}
		location.reload();
	};
}