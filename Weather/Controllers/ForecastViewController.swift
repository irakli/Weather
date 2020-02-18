//
//  ForecastViewController.swift
//  Weather
//
//  Created by Irakli Chkuaseli on 2/15/20.
//  Copyright © 2020 Irakli Chkuaseli. All rights reserved.
//

import UIKit
import CoreLocation

class ForecastViewController: WeatherViewController {

	@IBOutlet weak var tableView: UITableView!
	
//	lazy var data = [ForecastSectionModel]()
	
	lazy var data = [
		ForecastSectionModel(
			header: ForecastHeaderModel(
				section: 0,
				weekday: "Monday".uppercased()
			),
			cells: [
				ForecastCellModel(icon: UIImage(), time: "10:00", description: "Aee", temperature: 15.3)
			]
		)
	]
	
    override func viewDidLoad() {
        super.viewDidLoad()

		tableView.delegate = self
		tableView.dataSource = self
		registerViews()
		
		getForecastData()
    }
	
	func registerViews() {
		tableView.register(
			UINib(nibName: "ForecastCell", bundle: nil),
			forCellReuseIdentifier: "ForecastCell"
		)
		
		tableView.register(
			UINib(nibName: "ForecastHeader", bundle: nil),
			forHeaderFooterViewReuseIdentifier: "ForecastHeader"
		)
	}
    
	override func displayErrorText(with error: String) {
		// TODO
	}
	
	func getForecastData() {
		toggleLoadingAnimation()
		
		let configuration = URLSessionConfiguration.default
		let session = URLSession(configuration: configuration)
		
		getForecastDetails(from: session)
	}
	
	func getForecastDetails(from session: URLSession) {
		print(constructForecastRequest().url!)
		
		let task = session.dataTask(with: constructForecastRequest()) { [weak self] (data, response, error) in
			guard let data = data, let httpResponse = response as? HTTPURLResponse else {
				self!.displayErrorText(with: "Error loading forecast details")
				return
			}
			guard (200 ..< 300) ~= httpResponse.statusCode else {
				self!.displayErrorText(with: "Error loading forecast details")
				return
			}
			
			if let result = try? JSONDecoder().decode(ForecastResult.self, from: data) {
				if let weather = result.list.first {
					DispatchQueue.main.async {
						print(weather.main.temp)
						
						//
						//                                                            ``.,:;;;;;;;:,``
						//                                                      .:*#nxW@@@@@WWWWWWW@@@Mn+i,
						//                                                  .izM@@Wxz#*i::,,,,,,,,,,,:i*#nWWz*.
						//                                               `;nW@Mz*;,,,::::::::::::::::::::,,;+x@x*`
						//                                              ix@x+;,::::::::::::::::::::::::::::::,:+MW+`
						//                                            :xW#:,::::::::::::::::::::::::::::::::::::,*MW*`
						//                                          .zW+:::::::::::::::::::::::::::::::::::::::::::#Wx,
						//                                         :Wn:::::,,:::::::::::::::::::::::::::::::::::::::;MW:
						//                                       `+W*,:::,,..,::::::::::::::::::::::::::::::::::::::::xW;`
						//                                      `zM;::,,,....,::::::::::::::::::::::::::::::::::::::::,nW,
						//                                     `nM;:::,,....,,::::::::::::::::::::::::::::::::::::::::::xx`
						//                                    `nM::::,.....,:::::::::::::::::::::::::::::::::::::::::::::W+
						//                                    zW;:::,.....,::::::::::::::::::::::::::::::::::::::::::::::iW,
						//                                   *@*:::,....,,:::::::::::::::::::::::::::::::::::::::::::::::,nn
						//                                  ,Wz,::,....,,:::::::::::::::::::::::::::::::::*:::::::::::::::i@,
						//                                  nW::::,...,,:::::::::::::::::::::::::::::::::,n:::::::::::::::,M+
						//                                 :@+::::,..,::::::::::::::::::::::::::::::::::::;z:::::::::::::::#x
						//                                 #W:::::,,,,::::::::::::::::::::::::::::::::::::,x:::::::::::::::;@`
						//                                 W#::::::::::::::::::i;::::::::::::::::::::::::::#i::::::::::::::,W,
						//                                :@:::::::::::::::::::;Mi:::::::::::::::::::::::::i+::::::::::::::,z;
						//                                #x,::::::::::::::::::::Mi::::::::::::::::::::::::;z:::::::::::::::++
						//                                x+:::::::::::::::::::::;W:::::::::::::::::::::::::z,::::::::::::::i#
						//                               `Wi::::::::::::::::::::::+n,::::::::::::::::::::,::z,::::::::::::::;#
						//                               ,@,::::::::::::::::::::::,Mi:::::::::::::::::::,z::+,:i:::::::::::::z
						//                               iW,:::::::::::::::::::::::in,:::::::::::::::::::#+::::x,:::::::::::;n
						//                               #n,:::::::::::::::::::::::ix,::::::::::::::::::::n,::+*::::::::::::;M
						//                               z#::::::::::::::::::::::::##::::::::::::::::::::,z::,n,::::::::::::;@,
						//                               x+:::::::::::::::::::::::,W::::::::::::::::::::::i*:,n::::::::::::::Mx.
						//                               M*:::::::::::::::::::::::n+::::::::::::::::::::::,z:i#:::::::::::::::xn
						//                               Wi::::::::::::::::::::::n#,::::::::::::::::::::::,x,i+::::::::::::::::Wi
						//                               W;:::::::::::::::::::::+z,:::::::::::::::::::::::,x,i#::::::::::::::::+n
						//                               W;::::::::::::::::::::,M:::::::::::::::::::::::::i#:,n,:::::::::::::::;M
						//                               W;::::::::::::::::::::,M,::::::::::::::::::;::::,zi::z*::::::::::::::::M`
						//                               Wi::::::::::::::::::::,M,:::::::::::::::::zW:::::x,:::i::,::::::::::::*n
						//                               M*:::::::::::::::::::::zi:::::::::::::::+MW:,::::,::::::,z:::::::::::,ni
						//                               n#::::::::::::::::::::::M::::::::,,::izM#:ix+:::::::::::,#M:::::::::::M`
						//                               zn::::::::::::::::::::::i*::::::*MW@Wn*::::,+x::::::zi,*n**x+:,,,:::,ni
						//                               *M,:::::::::::::::::::::::::::::,;Mi,:::,::::;x,:::,x,#+,::,izWWz,:,z#
						//                               i@:::::::::::::::::::::::::;::::,x;:,::i***;:,++::::Wx;::::::::zi::+n
						//                               .@*::::::::::::::::::::::::Mi,,::x;#n#+MMMMzznix,:::@*,:*###*i,,x,,M;
						//                               `Mn,::::::::::::::::::::::::nMx*iWz:..,xxxx+.,#n,:::@inni:xxxMzznz*W.
						//                                zW:::::::::::::::::::::::::,,,::x.....#Mxx:..+*:::,nn:..,MxMM;,n##W
						//                                ;@*::::::::::::::::::::::::#zi:,z*.....;i,..;x,:::::M*...*MM#.,xn#@
						//                                 xx,::::::::::::::::::::::,:,,:::x*........:M::::::::zn.......+i;iM:
						//                                 iW;:::::::::::::::::,:::::::::::,zni,,,,:#M#,:::::::,x,....,#+,::*M,
						//                                 `Mz::::::::::::::::n::::::::::::::;+nxxxn*z+:::::::::##*i*#z;,:::,#M`
						//                                  *@;::::::::::::::+;::::::::::::::::,,,,,##,:::::::::#+;;;,,::::::,x+
						//                                  `Mx:::::::::::::,#,:::::::::::::::::,,;n#,::::::::::+nn*ii::::::::*M
						//                                   :@#,:::::::::::ii::::::::::::::::,#zMn;::::::::::::#+,*++::::::::i@
						//                                    +@*:::::::::::+:::::::::::::::::,ii:::::::::::::::#*::::::::::::iM
						//                                     z@*,:::::::::+::::::::::::::::::::::::::::::::::,x:::::::::::::+z
						//                                     `+W#,::::::::ii:::::::::::::::::::::::::::::::::,W,:::::::::::,ni
						//                                       ;Mx::::::::,#:::::::::::::::::::::::::::::::::;x,:::::::::::;W`
						//                                        `#W+:::::::+;::::::::::::::::::::::::::::::::*z::::::::::::M*`
						//                                          ,nM+:,::::z:::::::::::::::::::::W;:::::::::*M:::::::::::xz`
						//                                            :nWz*,,::z::::::::::::::::::,nz,:::::::::ixx:::::::::Mn`
						//                                              ,zW@+:::z;::::::::::::::::*M:::::::::::;z#z,:::::;Wz`
						//                                                `zn::::M#:,:::::::::::::W+:,,:::::::::x;x,::::*W+`
						//                                                 ##:::,Wzzn#*ii;,::::::#@;;Mx+,::::::,x+#:::,#W; `
						//                                                 x*::::W+:,;*+##x,:::::Wxx;M:z*:::::::#M+:::+M.
						//                                                .W:::::W*::::::,M,::::#n,#;*z,xi::::::z;n,:,M;`
						//                                                ;x,:::;@i::::::,M,::::W;::::,::M;:::,in,n:,,M,
						//                                                z+::::i@;::::::,M,:::*x,:::::::iMz#zn*::z*:,W.
						//                                               .@;::::*W:::::::,M,::,n+:::::::::,:;:,,::+#:,W`
						//                                               zx,::::+W,::::::,M,::,@;::::::::,,:::::::*z:,W`
						//                                              ,W+:::::+M,:::::::M,::iW,::::::,+x#,,*#:::iz:,W
						//                                              #W,:::::zx,::::::,;:::#z:::::::nn;*xM#*x::;+:,@
						//                                             `W+::::::nn,:::::::::::n+:::::,nn:::::::iz,::::@
						//                                             *M::::::,xz:::::::::::,Mi::::,nz:::;:::;:x:::::@
						//                                            .W*::::::,M#:::::::::::,M::::;x#:::#M,,#*:i#::::@
						//                                        ```,xx:::::::,W*::::::::::::;::::W#**+nWMnnxx#z#::::@
						//                               `:i+#nxxMMWM@W;:::::::,@*::::::::::::,::::+Wnz#i,:+i,:;x;::::@
						//                           ,izx@@WxxnMx;,,,z#:::::::::@;::::::::::::::::::#x:::::::::;x,::::@
						//                       `,+xWWMnz####nx,,::*M:::::::::;@:::::::::::::::::::,n#::::::::ni:::::@
						//                     .*x@Wxn#######zM:::::Wi:::::::::i@::::::::::::::::::::,n#,::::,zn,:::::W
						//                  `;n@Wxz+#########Wi::::nz::::::::::*M,::::::::::::::::::::,#Wx##zM#,::::::W
						//               `,+MWxz############xn,::::;:::::::::::*M,:::::::::::::::::::::,:i*+i,::::::::M
						//             `:zWMn##+############Wi:::::::::::::::::+x,::::::::::::::::::::::;:,,::::::::::M
						//            ;x@Mz################zM,:::::::::::::::::#n,::::::::::::::::::::::ixxxxi::::::::M
						//         `ixWx###################x#::::::::::::::::::#n:::::::::::::::::::::::::,,::::::::::@,
						//       `;xWMz###################+Wi::::::::::::::::::#x,::::::::::::::::::::::::::::::::::::*M#,
						//     `,nWMz######################@:::::::::::::::::::*W:::::::::::::::::::::::,+##+i:,:::::::,*W:
						//    `+@Wn########################M,:::::::::::::::::::W#:::::::::::::::::::::::;i*+zMn:::::::::*n
						//   ,x@n#########################zM,:::::::::::::::::::*Wi::::::::::::::::::::::::::,,#x,:::::::,M`
						//  iWM###########################zM,:::::::::::::::::::,#W*,::::::::::::::::::::::::::,xi:::::::,M`
						//`#Wn############################zM,::::::::::::::::::::,+Wz:::::::::::::::::::::::::::*#::::::::n.
						//xWz##############################W,:::::::::::::::::::::,iMW+::::::::::::::::::::::::::n,:::::::nz`
						//M################################@::::::::::::::::::::::::,+WM*,::::::::::::::::::::::,x,::::::,WM#
						//#####znnnnnz#####################@;::::::::::::::::::::::::::#WM*,:::::::::::::::::::::n,::::,;Mn#M;
						//#nMW@WWMMMWW@WMn#################M*::::::::::::::::::::::::::::+MW#;,:::::::::::::::::i#,::,inWz##zWz;``
						//@Mxzz##+++##znMWWx###############nz,::::::::::::::::::::::::::::,in@x+:,:::::::::::::,n*;*zM@x#####x@Wx;`
						//################nWWn#############zM,::::::::::::::::::::::::::::::,:+M@n+:,::::::::,:#@MWnnz+#######W+nWn.
						//##################x@M#############W;:::::::::::::::::::::::::::::::::,;#M@x+;:,,,:izWz:;W###########n###xM;``
						//###################zMWz###########x#::::::::::::::::::::::::::::::::::::,;+@WWMMWWx#:,:;W################zW*`
						//#####################MWz###########W,:::::::::::::::::::::::::::::::::::::,M,,::,,,::::;M##################Wi
						//######################xWz##########x+,::::++:,::::::::::::::::::::::::::::ix,:,::::::::ix###################W;
						//#######################xW###########W;::,xiin:::::::::::::::::::::::::::::x+::::::::,:,zz###################zW.
						//########################MM##########nM:,,x,::n,:::::::::::::::::::::::,:+Wz,:::::::::::W+####################xn
						//#########################Wx##########Mn,,zz+:#::::::::::::::::::::::::+Mz;,::::::::::,nz######################W;
						//#########################zWz##########W*::;i:#:,,,::::::::::::::::::::,,,::::::::::::*x#######################nx`
						//#########################+xM###########W;:::,n,*xn*:::::::::::::::::::::::::::::::::iM#########################W;
						//###########################Wz##########zM:,:z*;x,,n,:::::::::::::::::::::::::::::::iM##########################nn
						//###########################nM###########zx;x+:#+::+;::::::::::::::,,:::::::::::,:,*M############################W`
						//############################Wz###########nW+,,x:*,z:*+:::::;+;::::#xi::::::::::,:*M#############################M:
						
						
						// და ა.შ. მეზარება 5 ქულის გამო წვალება :-)
					}
				}
			}
			
		}
		
		task.resume()
	}
	
	override func toggleLoadingAnimation() {
		// nada
	}
	
	func constructForecastRequest() -> URLRequest {
		let api = "https://api.openweathermap.org"
		let endpoint = "/data/2.5/forecast"
		let query = "?lat=\(location.latitude)&lon=\(location.longitude)"
		let params = "&appid=\(apiKey)&units=metric"
		let url = URL(string: api + endpoint + query + params)
		
		var request = URLRequest(url: url!)
		request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
		request.httpMethod = "POST"
		
		return request
	}

	@IBAction func refresh(_ sender: Any) {
		print("refreysh")
	}
	
}

extension ForecastViewController: UITableViewDataSource, UITableViewDelegate {
	func numberOfSections(in tableView: UITableView) -> Int {
		return data.count
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 44
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 66
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return data[section].numberOfRows
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath) as! ForecastCell
		cell.configure(from: data[indexPath.section].cells[indexPath.row])
		
        return cell
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ForecastHeader") as! ForecastHeader
        if let model = data[section].header {
			header.configure(from: model)
        }
		
        return header
    }
}

extension ForecastViewController: CLLocationManagerDelegate {
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		displayErrorText(with: "Location error: \(error.localizedDescription)")
	}

	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		location = (manager.location?.coordinate)!

		getForecastData()
		locationManager.stopUpdatingLocation()
	}
}
