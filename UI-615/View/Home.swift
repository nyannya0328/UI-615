//
//  Home.swift
//  UI-615
//
//  Created by nyannyan0328 on 2022/07/18.
//

import SwiftUI

struct Home: View {
    @State var isTapped : Bool = false
    @State var currentTab : Tab = sampleTabs.first!
    
    @State var offset : CGFloat = 0
    var body: some View {
        GeometryReader{proxy in
            
             let scrrenSize = proxy.size
            
            
            ZStack(alignment: .top) {
                
                TabView(selection: $currentTab) {
                    
                    
                    ForEach(sampleTabs){tab in
                        
                        
                        GeometryReader{proxy in
                            
                            
                             let size = proxy.size
                            
                            Image(tab.sampleImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: size.width,height: size.height)
                                .clipped()
                            
                        }
                        .ignoresSafeArea()
                        .offsetX(competition: { value in
                            
                            if currentTab == tab && !isTapped{
                                
                                offset = value - (scrrenSize.width * CGFloat(indexOffset(tab: tab)))
                            }
                            
                            if value == 0 && isTapped{
                                
                                isTapped = false
                            }
                            
                        
                            
                            
                        })
                        .tag(tab)
                    }
                    
                    
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                
                
                
                
                
                
            }
            .ignoresSafeArea()
            .onAppear{}
            .onDisappear{}
            .frame(width: scrrenSize.width,height: scrrenSize.height)
            
            
            DynamicHeader(size: scrrenSize)
        }
    }
    
    @ViewBuilder
    func DynamicHeader(size : CGSize) -> some View{
        
        
        VStack(alignment: .leading){
            
            Text("Dynamic Tabs")
                .font(.title.weight(.black))
                .foregroundColor(.white)
            
            
            HStack(spacing:0){
                
                ForEach(sampleTabs){tab in
                    
                    Text(tab.tabName)
                        .fontWeight(.bold)
                      
                        .frame(maxWidth: .infinity,alignment: .center)
                        .foregroundColor(.white)
                        .padding(.vertical,5)
                }
            }
            .overlay(alignment:.leading) {
                
                
                Capsule()
                    .fill(.white)
                    .overlay(alignment: .leading) {
                        
                        GeometryReader{_ in
                            
                            HStack(spacing:0){
                                
                                ForEach(sampleTabs){tab in
                                    
                                    Text(tab.tabName)
                                        .fontWeight(.bold)
                                        .padding(.vertical,5)
                                        .frame(maxWidth: .infinity,alignment: .center)
                                       
                                        .foregroundColor(.black)
                                        .contentShape(Capsule())
                                        .onTapGesture {
                                            
                                            withAnimation(.easeInOut){
                                                
                                                isTapped = true
                                                currentTab = tab
                                                offset = -(size.width) * CGFloat(indexOffset(tab: tab))
                                            }
                                        }
                                    
                                    
                                }
                            }
                            .offset(x:-tabOffset(size: size, padding: 30))
                        }
                        .frame(width:size.width - 30)
                        
                        
                        
                    }
                    .frame(width:(size.width - 30) / CGFloat(sampleTabs.count))
                    .mask {
                        Capsule()
                            
                    }
                    .offset(x:tabOffset(size: size, padding: 30))
                
            }
          
          
            
            
            
            
        }
        .frame(maxWidth: .infinity,alignment: .leading)
        .padding(15)
         .background{
             
             Rectangle()
                 .fill(.ultraThinMaterial)
                 .ignoresSafeArea()
            
        }
        
        
    }
    func tabOffset(size : CGSize, padding : CGFloat)->CGFloat{
        
        return (-offset / size.width) * ((size.width - padding) / CGFloat(sampleTabs.count))
        
    }
    
    func indexOffset(tab : Tab) -> Int{
        
        let index = sampleTabs.firstIndex { CAB in
            CAB == tab
        } ?? 0
        
        return index
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
