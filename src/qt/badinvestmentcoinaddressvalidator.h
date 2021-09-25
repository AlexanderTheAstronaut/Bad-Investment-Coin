// Copyright (c) 2011-2014 The Bitcoin Core developers
// Distributed under the MIT software license, see the accompanying
// file COPYING or http://www.opensource.org/licenses/mit-license.php.

#ifndef BADINVESTMENTCOIN_QT_BADINVESTMENTCOINADDRESSVALIDATOR_H
#define BADINVESTMENTCOIN_QT_BADINVESTMENTCOINADDRESSVALIDATOR_H

#include <QValidator>

/** Base58 entry widget validator, checks for valid characters and
 * removes some whitespace.
 */
class BadinvestmentcoinAddressEntryValidator : public QValidator
{
    Q_OBJECT

public:
    explicit BadinvestmentcoinAddressEntryValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

/** Badinvestmentcoin address widget validator, checks for a valid badinvestmentcoin address.
 */
class BadinvestmentcoinAddressCheckValidator : public QValidator
{
    Q_OBJECT

public:
    explicit BadinvestmentcoinAddressCheckValidator(QObject *parent);

    State validate(QString &input, int &pos) const;
};

#endif // BADINVESTMENTCOIN_QT_BADINVESTMENTCOINADDRESSVALIDATOR_H
