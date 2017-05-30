import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Pattern;

//NOTE: need to fix P/E ratio and market cap 
public class StockFetcher {  

	public static class Stock { 
	
		private String symbol; 
		private double price;
		private int volume;
		private double pe;
		private double eps;
		private double week52low;
		private double week52high;
		private double daylow;
		private double dayhigh;
		private double movingav50day;
		private double marketcap;
		private String name;
		private String currency;
		private double shortRatio;
		private double previousClose;
		private double open;
		private String exchange;
	
		public Stock(String symbol, double price, int volume, double pe, double eps, double week52low,      
						double week52high, double daylow, double dayhigh, double movingav50day, double marketcap, String name, String currency, double shortRatio, double previousClose, double open, String exchange) {	
			this.symbol = symbol; 
			this.price = price;	
			this.volume = volume; 
			this.pe = pe; 
			this.eps = eps; 
			this.week52low = week52low; 
			this.week52high = week52high; 
			this.daylow = daylow; 
			this.dayhigh = dayhigh; 
			this.movingav50day = movingav50day; 
			this.marketcap = marketcap;
			this.name = name;
			this.currency = currency;
			this.shortRatio = shortRatio;
			this.previousClose = previousClose;
			this.open = open;
			this.exchange = exchange;
		} 
		
		public String getExchange(){
			return this.exchange;
		}
		
		public double getPreviousClose(){
			return this.previousClose;
		}
		
		public double getOpen(){
			return this.open;
		}
		
		public double getShortRatio(){
			return this.shortRatio;
		}
		
		public String getCurrency(){
			return this.currency;
		}
		
		public String getSymbol() { 
			return this.symbol;		
		} 
		
		public double getPrice() { 		
			return this.price;		
		} 
		
		public int getVolume() {    
			return this.volume;     
		} 
	 
		public double getPe() {    
			return this.pe;     
		} 
	  
		public double getEps() { 
			return this.eps;     
		} 
	  
		public double getWeek52low() {    
			return this.week52low;    
		} 
	  
		public double getWeek52high() {  
			return this.week52high;    
		} 
	  
		public double getDaylow() {    
			return this.daylow;    
		} 
	  
		public double getDayhigh() {    
			return this.dayhigh;     
		} 
	  
		public double getMovingav50day() {     
			return this.movingav50day;  
		} 
	  
		public double getMarketcap() { 
			return this.marketcap;
		} 
		
		public String getName(){
			return this.name;
		}
	}
	
	public static class StockHelper {
	
		public StockHelper() {
		
		}
	
		public double handleDouble(String x) {
			Double y;
			if (Pattern.matches("N/A", x)) {  
				y = 0.00;   
			} else { 
				y = Double.parseDouble(x);  
			}  
			return y;
		}
		
		public int handleInt(String x) {
			int y;
			if (Pattern.matches("N/A", x)) {  
				y = 0;   
			} else { 
				y = Integer.parseInt(x);  
			} 
			return y;
		}

	}
	
	static Stock getStock(String symbol) {  
		String sym = symbol.toUpperCase();
		double price = 0.0;
		int volume = 0;
		double pe = 0.0;
		double eps = 0.0;
		double week52low = 0.0;
		double week52high = 0.0;
		double daylow = 0.0;
		double dayhigh = 0.0;
		double movingav50day = 0.0;
		double marketcap = 0.0;
		String name = "";
		String currency = "";
		double shortRatio = 0.0;
		double open = 0.0;
		double previousClose = 0.0;
		String exchange;
		try { 
			
			// Retrieve CSV File
			URL yahoo = new URL("http://finance.yahoo.com/d/quotes.csv?s="+ symbol + "&f=l1vr2ejkghm3j3nc4s7pox");
			URLConnection connection = yahoo.openConnection(); 
			InputStreamReader is = new InputStreamReader(connection.getInputStream());
			BufferedReader br = new BufferedReader(is);  
			
			// Parse CSV Into Array
			String line = br.readLine(); 
			//Only split on commas that aren't in quotes
			String[] stockinfo = line.split(",(?=(?:[^\"]*\"[^\"]*\")*[^\"]*$)");
			
			// Handle Our Data
			StockHelper sh = new StockHelper();
			
			price = sh.handleDouble(stockinfo[0]);
			volume = sh.handleInt(stockinfo[1]);
			pe = sh.handleDouble(stockinfo[2]);
			eps = sh.handleDouble(stockinfo[3]);
			week52low = sh.handleDouble(stockinfo[4]);
			week52high = sh.handleDouble(stockinfo[5]);
			daylow = sh.handleDouble(stockinfo[6]);
			dayhigh = sh.handleDouble(stockinfo[7]);   
			movingav50day = sh.handleDouble(stockinfo[8]);
			marketcap = sh.handleDouble(stockinfo[9]);
			name = stockinfo[10].replace("\"", "");
			currency = stockinfo[11].replace("\"", "");
			shortRatio = sh.handleDouble(stockinfo[12]);
			previousClose = sh.handleDouble(stockinfo[13]);
			open = sh.handleDouble(stockinfo[14]);
			exchange = stockinfo[15].replace("\"", "");
			
		} catch (IOException e) {
			Logger log = Logger.getLogger(StockFetcher.class.getName()); 
			log.log(Level.SEVERE, e.toString(), e);
			return null;
		}
		
		return new Stock(sym, price, volume, pe, eps, week52low, week52high, daylow, dayhigh, movingav50day, marketcap, name,currency, shortRatio,previousClose,open,exchange);
		
	}
	
	public static void testStock() { 
		
		Stock facebook = StockFetcher.getStock("FB");
		System.out.println("Price: " + facebook.getPrice());
		System.out.println("Volume: " + facebook.getVolume()); 
		System.out.println("P/E: " + facebook.getPe());
		System.out.println("EPS: " + facebook.getEps());
		System.out.println("Year Low: " + facebook.getWeek52low());
		System.out.println("Year High: " + facebook.getWeek52high());
		System.out.println("Day Low: " + facebook.getDaylow());
		System.out.println("Day High: " + facebook.getDayhigh());
		System.out.println("50 Day Moving Av: " + facebook.getMovingav50day());
		System.out.println("Market Cap: " + facebook.getMarketcap());
		System.out.println("The full name is: " + facebook.getName());
		System.out.println("The currency is: " + facebook.getCurrency());
		System.out.println("The short ratio is: " + facebook.getShortRatio());
		System.out.println("The previous close was: " + facebook.getPreviousClose());
		System.out.println("The open for today was: " + facebook.getOpen());
		System.out.println("The exchange is " + facebook.getExchange());
		
	} 
	
	
	public static void getInfo(String ticker) { 
		
		Stock info = StockFetcher.getStock(ticker);
		System.out.println("Price: " + info.getPrice());
		System.out.println("Volume: " + info.getVolume()); 
		//System.out.println("P/E: " + info.getPe());
		System.out.println("EPS: " + info.getEps());
		System.out.println("Year Low: " + info.getWeek52low());
		System.out.println("Year High: " + info.getWeek52high());
		System.out.println("Day Low: " + info.getDaylow());
		System.out.println("Day High: " + info.getDayhigh());
		System.out.println("50 Day Moving Av: " + info.getMovingav50day());
		//System.out.println("Market Cap: " + info.getMarketcap());
		System.out.println("The full name is: " + info.getName());
		System.out.println("The currency is: " + info.getCurrency());
		System.out.println("The short ratio is: " + info.getShortRatio());
		System.out.println("The previous close was: " + info.getPreviousClose());
		System.out.println("The open for today was: " + info.getOpen());
		System.out.println("The exchange is " + info.getExchange());
		System.out.println("\n");
		
	} 
	
	//testing
	public static void main (String[] args){
		//getInfo("AAPL");
		//getInfo("GOOGL");
		//getInfo("DIS");
		getInfo("FB");
	}
}