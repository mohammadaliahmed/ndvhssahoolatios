//
//  APIRequest.swift
//  ndvhssahoolat
//
//  Created by MIS on 08/02/2021.
//

import Foundation

enum APIError:Error {
    case responseProblem
    case decodingProblem
    case encodingProblem
}

struct APIRequest{
    let resourceURL:URL
    
    init(endpoint:String){
        let resourceString="http://sahoolat.ndvhs.com/api/\(endpoint)"
        guard let resourceURL=URL(string: resourceString) else{fatalError()}
        self.resourceURL=resourceURL
        
    }
    func getDepartments(postRequest:PostRequest, completion:@escaping(Result<APIResponse,APIError>)->Void){
        do{
            var urlRequest=URLRequest(url: resourceURL)
            urlRequest.httpMethod="POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody=try JSONEncoder().encode(postRequest)
            let dataTask=URLSession.shared.dataTask(with: urlRequest){data,response,_ in
                guard let httpResponse=response as? HTTPURLResponse, httpResponse.statusCode==200,let
                        jsonData=data else{
                    completion(.failure(.responseProblem))
                    return
                }
                do{
                    let messageData=try JSONDecoder().decode(APIResponse.self,from: jsonData)
                    completion(.success(messageData))
                    
                }catch{
                    completion(.failure(.decodingProblem))
                }
            }
            dataTask.resume()
        }catch{
            completion(.failure(.encodingProblem))
        }
    }
    func updateProfile(postRequest:PostRequest, completion:@escaping(Result<APIResponse,APIError>)->Void){
        do{
            var urlRequest=URLRequest(url: resourceURL)
            urlRequest.httpMethod="POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody=try JSONEncoder().encode(postRequest)
            let dataTask=URLSession.shared.dataTask(with: urlRequest){data,response,_ in
                guard let httpResponse=response as? HTTPURLResponse, httpResponse.statusCode==200,let
                        jsonData=data else{
                    completion(.failure(.responseProblem))
                    return
                }
                do{
                    let messageData=try JSONDecoder().decode(APIResponse.self,from: jsonData)
                    completion(.success(messageData))
                    
                }catch{
                    completion(.failure(.decodingProblem))
                }
            }
            dataTask.resume()
        }catch{
            completion(.failure(.encodingProblem))
        }
    }
    func loginUser(postRequest:PostRequest, completion:@escaping(Result<APIResponse,APIError>)->Void){
        do{
            var urlRequest=URLRequest(url: resourceURL)
            urlRequest.httpMethod="POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody=try JSONEncoder().encode(postRequest)
            let dataTask=URLSession.shared.dataTask(with: urlRequest){data,response,_ in
                guard let httpResponse=response as? HTTPURLResponse, httpResponse.statusCode==200,let
                        jsonData=data else{
                    completion(.failure(.responseProblem))
                    return
                }
                do{
                    let messageData=try JSONDecoder().decode(APIResponse.self,from: jsonData)
                    completion(.success(messageData))
                    
                }catch{
                    completion(.failure(.decodingProblem))
                }
            }
            dataTask.resume()
        }catch{
            completion(.failure(.encodingProblem))
        }
    }
    func hometickets(postRequest:PostRequest, completion:@escaping(Result<APIResponse,APIError>)->Void){
        do{
            var urlRequest=URLRequest(url: resourceURL)
            urlRequest.httpMethod="POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody=try JSONEncoder().encode(postRequest)
            let dataTask=URLSession.shared.dataTask(with: urlRequest){data,response,_ in
                guard let httpResponse=response as? HTTPURLResponse, httpResponse.statusCode==200,let
                        jsonData=data else{
                    completion(.failure(.responseProblem))
                    return
                }
                if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                   print(JSONString)
                }
                do{
                    let messageData=try JSONDecoder().decode(APIResponse.self,from: jsonData)
                    completion(.success(messageData))
                    
                }catch{
                    completion(.failure(.decodingProblem))
                }
            }
            dataTask.resume()
        }catch{
            completion(.failure(.encodingProblem))
        }
    }
    
    func createTicket(postRequest:PostRequest, completion:@escaping(Result<APIResponse,APIError>)->Void){
        do{
            var urlRequest=URLRequest(url: resourceURL)
            urlRequest.httpMethod="POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody=try JSONEncoder().encode(postRequest)
            let dataTask=URLSession.shared.dataTask(with: urlRequest){data,response,_ in
                guard let httpResponse=response as? HTTPURLResponse, httpResponse.statusCode==200,let
                        jsonData=data else{
                    completion(.failure(.responseProblem))
                    return
                }
                if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                   print(JSONString)
                }
                do{
                    let messageData=try JSONDecoder().decode(APIResponse.self,from: jsonData)
                    completion(.success(messageData))
                    
                }catch{
                    completion(.failure(.decodingProblem))
                }
            }
            dataTask.resume()
        }catch{
            completion(.failure(.encodingProblem))
        }
    }
}
