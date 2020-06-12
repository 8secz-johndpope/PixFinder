//
//  PhotoCollectionViewCell.swift
//  PixFinder
//
//  Created by Arinjoy Biswas on 10/6/20.
//  Copyright © 2020 Arinjoy Biswas. All rights reserved.
//

import UIKit
import Combine

final class PhotoCollectionViewCell: UICollectionViewCell, NibProvidable, ReusableView {

    // MARK: - UI Elements / Outlets

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var visualEffectView: UIVisualEffectView!
    @IBOutlet private weak var mainImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var userAvatarImageView: UIImageView!
    @IBOutlet private weak var tagsLabel: UILabel!
    @IBOutlet private weak var likesIconView: UIImageView!
    @IBOutlet private weak var likesLabel: UILabel!
    @IBOutlet private weak var commentsIconView: UIImageView!
    @IBOutlet private weak var commentsLabel: UILabel!
    @IBOutlet private weak var favouritesIconView: UIImageView!
    @IBOutlet private weak var favouritesLabel: UILabel!
    @IBOutlet private weak var downloadsIconView: UIImageView!
    @IBOutlet private weak var downloadsLabel: UILabel!

    // MARK: - Private Propertie

    private var cancellable: AnyCancellable?

    // MARK: - Lifecyle

    override func prepareForReuse() {
        super.prepareForReuse()
        cancelImageLoading()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        applyStyles()
    }

    // MARK: - Configuration

    func configure(with viewModel: PhotoViewModel) {

        userNameLabel.text = "By: " + viewModel.postedByUser.name
        tagsLabel.text = "Tags: " + viewModel.tags

        likesLabel.text = viewModel.likes
        commentsLabel.text = viewModel.comments
        favouritesLabel.text = viewModel.favourites
        downloadsLabel.text = viewModel.downloads

        cancellable = viewModel.mainImage
            .receive(on: RunLoop.main)
            .sink { [unowned self] image in
                self.showImage(image: image)
            }

        applyContainerShadowStyle()
    }

     func showImage(image: UIImage?) {
        cancelImageLoading()

        UIView.transition(
            with: mainImageView,
            duration: 0.3,
            options: [.curveEaseOut, .transitionCrossDissolve],
            animations: {
                self.mainImageView.image = image
            })
    }

    // MARK: - Private Helpers

    private func applyStyles() {
        self.backgroundColor = .clear
        containerView.backgroundColor = Theme.secondaryBackgroundColor
        mainImageView.backgroundColor = Theme.tertiaryBackgroundColor

        userAvatarImageView.image = UIImage(named: "user-avatar")
        likesIconView.image = UIImage(named: "speech-bubble")
        commentsIconView.image = UIImage(named: "like-up")
        favouritesIconView.image = UIImage(named: "heart-love")
        downloadsIconView.image = UIImage(named: "download")

        for view in [userNameLabel,
                     tagsLabel,
                     likesLabel,
                     commentsLabel,
                     favouritesLabel,
                     downloadsLabel] {
            view?.textColor = Theme.primaryTextColor
            view?.adjustsFontSizeToFitWidth = true
        }

        for view in [userAvatarImageView,
                     likesIconView,
                     commentsIconView,
                     favouritesIconView,
                     downloadsIconView] {
            view?.tintColor = Theme.primaryTextColor
            view?.contentMode = .scaleAspectFit
        }
    }

    private func applyContainerShadowStyle() {
        Shadow(color: Theme.primaryTextColor,
           opacity: 0.3,
           blur: 4,
           offset: CGSize(width: 0, height: 0))
        .apply(toView: self)

        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 8.0
    }

    private func cancelImageLoading() {
        mainImageView.image = nil
        cancellable?.cancel()
    }
}
