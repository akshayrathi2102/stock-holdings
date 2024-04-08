//
//  HoldingsFooterCollapsibleView.swift
//  StockHoldings
//
//  Created by Akshay Rathi on 23/02/24.
//

import Foundation
import UIKit

final class HoldingsFooterCollapsibleView: UIView {
    private enum ExpandCollapseState {
        case expanded
        case collapsed
    }
    private var state : ExpandCollapseState = .collapsed
    
    private let containerStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 12
        return view
    }()
    private let currentValueLeftRightView = HoldingsLeftRightView()
    private let totalInvestmentLeftRightView = HoldingsLeftRightView()
    private let todayPlLeftRightView = HoldingsLeftRightView()
    private let totalPlValueLeftRightView = HoldingsLeftRightView()
    private let topContainerView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 12
        return view
    }()
    private let bottomContainerView = UIView()
    private let arrowControl = UIControl()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        backgroundColor = .white
        setupViews()
        addTap()
        setRightTriangle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(data: UserHoldingsModel) {
        currentValueLeftRightView.config(leftTitle: StringConstants.currentValue,
                                         rightTitle: String(format: "₹%0.2f",
                                                            data.currentTotalValue),
                                         shouldBoldRightText: true)
        
        totalInvestmentLeftRightView.config(leftTitle: StringConstants.totalInvestment,
                                            rightTitle: String(format: "₹%0.2f",
                                                               data.totalInvestment),
                                            shouldBoldRightText: true)
        
        todayPlLeftRightView.config(leftTitle: StringConstants.todayProfitAndLoss,
                                    rightTitle: String(format: "₹%0.2f",
                                                       data.todayPl),
                                    shouldBoldRightText: true)
        
        totalPlValueLeftRightView.config(leftTitle: StringConstants.profitAndLoss,
                                         rightTitle: String(format: "₹%0.2f",
                                                            data.totalPl),
                                         shouldBoldRightText: true)
    }
    
    func toggleExpandCollapse() {
        state = (state == .expanded ? .collapsed : .expanded)
        UIView.animate(withDuration: 0.37) { [weak self] in
            self?.topContainerView.isHidden = self?.state == .collapsed
            let angleToRotate: CGFloat = (self?.state == .expanded ? 1 : 0)
            self?.arrowControl.layer.transform = CATransform3DMakeRotation(.pi, angleToRotate, 0, 0)
        }
    }
}

private extension HoldingsFooterCollapsibleView {
    func addTap() {
        arrowControl.addTarget(self, action: #selector(handleArrowTap), for: .touchUpInside)
    }
    
    func setupViews() {
        addSubview(containerStackView)
        containerStackView.addArrangedSubview(arrowControl)
        containerStackView.addArrangedSubview(topContainerView)
        containerStackView.addArrangedSubview(bottomContainerView)
        
        topContainerView.isHidden = true
        topContainerView.addArrangedSubview(currentValueLeftRightView)
        topContainerView.addArrangedSubview(totalInvestmentLeftRightView)
        topContainerView.addArrangedSubview(todayPlLeftRightView)
        
        bottomContainerView.addSubview(totalPlValueLeftRightView)
        
        containerStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(12)
        }
        
        arrowControl.snp.makeConstraints { make in
            make.height.equalTo(24)
        }
        
        totalPlValueLeftRightView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.top.equalTo(12)
        }
    }
    
    func setRightTriangle() {
        let heightWidth: CGFloat = 24
        let path = CGMutablePath()
        let xOffset = UIScreen.main.bounds.width/2 - heightWidth
        let yOffset = heightWidth/4
        path.move(to: CGPoint(x: xOffset, y: heightWidth - yOffset))
        path.addLine(to: CGPoint(x:xOffset + heightWidth/2, y: heightWidth/2 - yOffset))
        path.addLine(to: CGPoint(x:xOffset + heightWidth, y:heightWidth - yOffset))
        path.addLine(to: CGPoint(x:xOffset, y:heightWidth - yOffset))
        
        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = UIColor.purple.cgColor
        
        arrowControl.layer.insertSublayer(shape, at: 0)
    }
    
    @objc
    func handleArrowTap() {
        toggleExpandCollapse()
    }
}
